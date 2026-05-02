#!/bin/bash
# netboot-prerequisites.sh
# Post-install script voor Devuan headless netboot-server
# Detecteert NICs automatisch

set -e

# Kleuren voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_question() { echo -e "${BLUE}[?]${NC} $1"; }

# Controleer root
if [ "$EUID" -ne 0 ]; then 
    log_error "Dit script moet als root worden uitgevoerd (sudo)"
    exit 1
fi

# Functie: verzamel alle fysieke NICs (geen virtual, geen loopback)
get_physical_nics() {
    # Zoek naar interfaces met een PCI-path (echte hardware)
    local nics=""
    for iface in $(ls /sys/class/net/ | grep -v lo); do
        if [ -e "/sys/class/net/${iface}/device" ]; then
            nics="${nics} ${iface}"
        fi
    done
    echo $nics
}

# Functie: check of een interface een IP heeft (inclusief DHCP)
has_ip() {
    ip addr show $1 2>/dev/null | grep -q "inet " && return 0 || return 1
}

# Functie: krijg IP-adres van interface
get_ip() {
    ip addr show $1 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1
}

# Detecteer alle fysieke NICs
log_info "Detecteren van netwerkinterfaces..."
ALL_NICS=$(get_physical_nics)

if [ -z "$ALL_NICS" ]; then
    log_error "Geen fysieke netwerkinterfaces gevonden!"
    exit 1
fi

log_info "Gevonden interfaces:"
for iface in $ALL_NICS; do
    if has_ip $iface; then
        ip=$(get_ip $iface)
        echo "  - $iface (heeft IP: $ip)"
    else
        echo "  - $iface (geen IP)"
    fi
done
echo ""

# Bepaal WAN interface (degene met IP in 192.168.178.x)
WAN_IF=""
LAN_IF=""

for iface in $ALL_NICS; do
    if has_ip $iface; then
        ip=$(get_ip $iface)
        if [[ "$ip" == 192.168.178.* ]]; then
            WAN_IF="$iface"
            log_info "WAN interface gedetecteerd: $iface (IP: $ip)"
        fi
    fi
done

# Als er meerdere NICs zonder IP zijn, kies er één voor LAN
NO_IP_NICS=""
for iface in $ALL_NICS; do
    if ! has_ip $iface; then
        NO_IP_NICS="${NO_IP_NICS} $iface"
    fi
done

# Bepaal LAN interface
if [ -z "$WAN_IF" ]; then
    log_warn "Geen interface met 192.168.178.x IP gevonden"
    log_question "Welke interface is verbonden met jouw router (internet)?"
    select WAN_IF in $ALL_NICS; do
        if [ -n "$WAN_IF" ]; then break; fi
    done
fi

# Als er maar één NIC zonder IP is, gebruik die
if [ $(echo $NO_IP_NICS | wc -w) -eq 1 ]; then
    LAN_IF="$NO_IP_NICS"
    log_info "LAN interface gedetecteerd: $LAN_IF (nog geen IP)"
else
    # Anders vraag aan de gebruiker
    log_question "Welke interface wordt gebruikt voor Netboot (PXE-clients)?"
    select LAN_IF in $NO_IP_NICS; do
        if [ -n "$LAN_IF" ]; then break; fi
    done
fi

# Vaste configuratie
LAN_IP="10.0.0.1"
LAN_MASK="24"
LAN_CIDR="${LAN_IP}/${LAN_MASK}"
LAN_NETWORK="10.0.0.0"
DHCP_START="10.0.0.50"
DHCP_END="10.0.0.200"

echo ""
log_info "Gekozen configuratie:"
echo "  WAN interface (internet): ${WAN_IF}"
echo "  LAN interface (netboot): ${LAN_IF}"
echo "  Netboot IP: ${LAN_IP}/${LAN_MASK}"
echo "  DHCP range: ${DHCP_START} - ${DHCP_END}"
echo ""

read -p "Is dit correct? (j/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[JjYy]$ ]]; then
    log_error "Script gestopt. Voer handmatig de juiste interfaces in."
    exit 1
fi

# ============================================
# BEGIN INSTALLATIE
# ============================================

log_info "Starten met installatie..."

# Update systeem
apt update
apt upgrade -y

# Installeer packages
log_info "Installeren Netboot prerequisites..."
apt install -y \
    dnsmasq \
    tftpd-hpa \
    nfs-kernel-server \
    nginx \
    wget curl unzip \
    vim net-tools htop

# Stop services
systemctl stop dnsmasq tftpd-hpa nginx 2>/dev/null || true

# Maak directories
log_info "Aanmaken directory structuur..."
mkdir -p /srv/tftp /srv/nfs /var/www/netboot

# Download netboot.xyz
log_info "Downloaden netboot.xyz bootloaders..."
cd /srv/tftp
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.efi
chmod 644 /srv/tftp/*

# Download Devuan netboot
log_info "Downloaden Devuan netboot image..."
cd /tmp
wget -q --show-progress https://deb.devuan.org/devuan/dists/excalibur/main/installer-amd64/current/images/netboot/netboot.tar.gz || {
    wget -q --show-progress https://mirror.dogado.de/devuan/devuan/dists/excalibur/main/installer-amd64/current/images/netboot/netboot.tar.gz
}
tar -xzf netboot.tar.gz -C /srv/tftp/
rm -f netboot.tar.gz

# Configureer statisch IP voor LAN interface
log_info "Configureren statisch IP voor ${LAN_IF}..."
cat > /etc/network/interfaces.d/${LAN_IF} << EOF
auto ${LAN_IF}
iface ${LAN_IF} inet static
    address ${LAN_IP}
    netmask 255.255.255.0
EOF

# Backup dnsmasq config
if [ -f /etc/dnsmasq.conf ]; then
    cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup.$(date +%Y%m%d_%H%M%S)
fi

# Configureer dnsmasq
log_info "Configureren dnsmasq..."
cat > /etc/dnsmasq.conf << EOF
interface=${LAN_IF}
bind-interfaces
dhcp-range=${DHCP_START},${DHCP_END},12h
dhcp-option=option:router,${LAN_IP}
dhcp-option=option:dns-server,8.8.8.8,8.8.4.4

enable-tftp
tftp-root=/srv/tftp

# PXE boot
dhcp-match=set:bios,60,PXEClient:Arch:00000
dhcp-boot=tag:bios,netboot.xyz.kpxe

dhcp-match=set:efi64,60,PXEClient:Arch:00007
dhcp-boot=tag:efi64,netboot.xyz.efi

dhcp-boot=netboot.xyz.kpxe

log-dhcp
EOF

# Configureer tftpd-hpa
cat > /etc/default/tftpd-hpa << EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --create"
EOF

# Configureer NFS
cat > /etc/exports << EOF
/srv/nfs ${LAN_NETWORK}/${LAN_MASK}(rw,sync,no_subtree_check,no_root_squash)
/srv/tftp ${LAN_NETWORK}/${LAN_MASK}(ro,sync,no_subtree_check)
EOF

# Configureer nginx
cat > /etc/nginx/sites-available/netboot << EOF
server {
    listen 80;
    server_name _;
    root /var/www/netboot;
    autoindex on;
    location /tftp { alias /srv/tftp; autoindex on; }
    location /nfs { alias /srv/nfs; autoindex on; }
}
EOF

ln -sf /etc/nginx/sites-available/netboot /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Status webpagina
cat > /var/www/netboot/index.html << EOF
<!DOCTYPE html>
<html>
<head><title>Netboot Server</title></head>
<body>
<h1>Netboot Server - Devuan</h1>
<p>Netboot netwerk: ${LAN_NETWORK}/${LAN_MASK}</p>
<p>DHCP: ${DHCP_START} - ${DHCP_END}</p>
<ul>
    <li><a href="/tftp/">TFTP</a></li>
    <li><a href="/nfs/">NFS</a></li>
</ul>
</body>
</html>
EOF

# Start services
systemctl daemon-reload
systemctl enable networking dnsmasq tftpd-hpa nfs-kernel-server nginx
systemctl restart dnsmasq tftpd-hpa nfs-kernel-server nginx

# Check services
echo ""
log_info "Service status:"
for svc in dnsmasq tftpd-hpa nfs-kernel-server nginx; do
    if systemctl is-active --quiet $svc; then
        echo "  ✓ $svc"
    else
        echo "  ✗ $svc"
    fi
done

# Eindoverzicht
echo ""
echo "=========================================="
log_info "INSTALLATIE VOLTOOID"
echo "=========================================="
echo "WAN (internet): ${WAN_IF} -> jouw router (192.168.178.1)"
echo "LAN (netboot):  ${LAN_IF} -> switch -> PXE-clients"
echo "Server IP:      ${LAN_IP}"
echo "Web interface:  http://${LAN_IP}"
echo ""
echo "BELANGRIJK: De switch met PXE-clients mag"
echo "NIET verbonden zijn met jouw router!"
echo "=========================================="
echo ""
log_warn "Herstart de server: reboot"