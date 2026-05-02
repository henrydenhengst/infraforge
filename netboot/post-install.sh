#!/bin/bash
# netboot-automatic.sh
# Volledig autonome Netboot-server installatie voor Devuan
# Detecteert NICs automatisch zonder gebruikersinteractie

set -e

# Kleuren voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Controleer root
if [ "$EUID" -ne 0 ]; then 
    log_error "Dit script moet als root worden uitgevoerd (sudo)"
    exit 1
fi

# ============================================
# CHECK OF HET SYSTEEM DEVUAN IS
# ============================================

log_info "Controleren of systeem Devuan is..."

# Devuan herkennen aan /etc/devuan_version of aan de aanwezigheid van 'devuan' in os-release
if [ -f /etc/devuan_version ]; then
    log_info "Devuan versie: $(cat /etc/devuan_version)"
elif [ -f /etc/os-release ] && grep -qi "devuan" /etc/os-release; then
    log_info "Devuan gedetecteerd via os-release"
else
    # Geen Devuan, stop installatie
    echo ""
    echo "=========================================="
    echo "INSTALLATIE GESTOPT"
    echo "=========================================="
    echo "Dit script is alleen voor Devuan Linux."
    echo ""
    echo "Gedetecteerd besturingssysteem:"
    if [ -f /etc/os-release ]; then
        grep "^PRETTY_NAME=" /etc/os-release | cut -d= -f2 | tr -d '"'
    elif [ -f /etc/debian_version ]; then
        echo "Debian (niet Devuan)"
    else
        echo "Onbekend (geen Devuan)"
    fi
    echo ""
    echo "Dit script werkt alleen op Devuan vanwege:"
    echo "  - Afwezigheid van systemd (gebruikt sysvinit/OpenRC)"
    echo "  - Netwerk configuratie via /etc/network/interfaces"
    echo "  - Specifieke package namen en paden"
    echo "=========================================="
    exit 1
fi

# ============================================
# AUTOMATISCHE NIC DETECTIE
# ============================================

log_info "Automatisch detecteren van netwerkinterfaces..."

# Verzamel alle fysieke NICs
get_physical_nics() {
    local nics=""
    for iface in $(ls /sys/class/net/ 2>/dev/null | grep -v lo); do
        if [ -e "/sys/class/net/${iface}/device" ]; then
            nics="${nics} ${iface}"
        fi
    done
    echo $nics
}

# Check of interface een IP heeft
has_ip() {
    ip addr show $1 2>/dev/null | grep -q "inet " && return 0 || return 1
}

# IP van interface ophalen
get_ip() {
    ip addr show $1 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d/ -f1 | head -1
}

ALL_NICS=$(get_physical_nics)

if [ -z "$ALL_NICS" ]; then
    log_error "Geen fysieke netwerkinterfaces gevonden!"
    exit 1
fi

# Detecteer WAN (192.168.178.x)
WAN_IF=""
LAN_IF=""

for iface in $ALL_NICS; do
    if has_ip $iface; then
        ip=$(get_ip $iface)
        if [[ "$ip" == 192.168.178.* ]]; then
            WAN_IF="$iface"
            log_info "WAN interface: $iface (IP: $ip)"
        fi
    fi
done

# Verzamel NICs zonder IP
NO_IP_NICS=""
for iface in $ALL_NICS; do
    if ! has_ip $iface; then
        NO_IP_NICS="${NO_IP_NICS} $iface"
    fi
done

# Bepaal LAN (eerste NIC zonder IP)
if [ -n "$NO_IP_NICS" ]; then
    LAN_IF=$(echo $NO_IP_NICS | awk '{print $1}')
    log_info "LAN interface: $LAN_IF (geen IP, wordt netboot)"
else
    log_error "Geen beschikbare interface voor netboot gevonden!"
    exit 1
fi

# Als WAN niet gedetecteerd is, gebruik dan de andere NIC als WAN
if [ -z "$WAN_IF" ]; then
    for iface in $ALL_NICS; do
        if [ "$iface" != "$LAN_IF" ]; then
            WAN_IF="$iface"
            log_warn "WAN niet automatisch gedetecteerd, gebruik: $WAN_IF"
            break
        fi
    done
fi

# Vaste netboot configuratie
LAN_IP="10.0.0.1"
LAN_MASK="24"
LAN_NETWORK="10.0.0.0"
DHCP_START="10.0.0.50"
DHCP_END="10.0.0.200"

log_info "Configuratie:"
log_info "  WAN (internet): ${WAN_IF} -> router (192.168.178.1)"
log_info "  LAN (netboot):  ${LAN_IF} -> ${LAN_IP}/${LAN_MASK}"
log_info "  DHCP range:     ${DHCP_START} - ${DHCP_END}"

# ============================================
# SYSTEEM UPDATE
# ============================================

log_info "Systeem updaten..."
apt update
apt upgrade -y

# ============================================
# PACKAGES INSTALLEREN
# ============================================

log_info "Netboot packages installeren..."
apt install -y \
    dnsmasq \
    tftpd-hpa \
    nfs-kernel-server \
    nginx \
    wget \
    curl \
    unzip \
    vim \
    net-tools \
    htop

# Stop services voor configuratie
systemctl stop dnsmasq tftpd-hpa nginx 2>/dev/null || true

# ============================================
# DIRECTORY STRUCTUUR
# ============================================

log_info "Directory structuur aanmaken..."
mkdir -p /srv/tftp /srv/nfs /var/www/netboot

# ============================================
# DOWNLOAD BOOTLOADERS
# ============================================

log_info "Netboot.xyz bootloaders downloaden..."
cd /srv/tftp
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.efi
chmod 644 /srv/tftp/*

log_info "Devuan netboot image downloaden..."
cd /tmp
wget -q --show-progress https://deb.devuan.org/devuan/dists/excalibur/main/installer-amd64/current/images/netboot/netboot.tar.gz 2>/dev/null || \
    wget -q --show-progress https://mirror.dogado.de/devuan/devuan/dists/excalibur/main/installer-amd64/current/images/netboot/netboot.tar.gz
tar -xzf netboot.tar.gz -C /srv/tftp/
rm -f netboot.tar.gz

# ============================================
# STATISCH IP VOOR LAN INTERFACE
# ============================================

log_info "Statisch IP configureren voor ${LAN_IF}..."
cat > /etc/network/interfaces.d/${LAN_IF} << EOF
auto ${LAN_IF}
iface ${LAN_IF} inet static
    address ${LAN_IP}
    netmask 255.255.255.0
EOF

# ============================================
# DNSMASQ CONFIGURATIE
# ============================================

log_info "Dnsmasq configureren..."
if [ -f /etc/dnsmasq.conf ]; then
    cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup.$(date +%Y%m%d_%H%M%S)
fi

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

# ============================================
# TFTPD-HPA CONFIGURATIE
# ============================================

log_info "Tftpd-hpa configureren..."
cat > /etc/default/tftpd-hpa << EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --create"
EOF

# ============================================
# NFS CONFIGURATIE
# ============================================

log_info "NFS configureren..."
cat > /etc/exports << EOF
/srv/nfs ${LAN_NETWORK}/${LAN_MASK}(rw,sync,no_subtree_check,no_root_squash)
/srv/tftp ${LAN_NETWORK}/${LAN_MASK}(ro,sync,no_subtree_check)
EOF

# ============================================
# NGINX CONFIGURATIE
# ============================================

log_info "Nginx configureren..."
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

# ============================================
# STATUS WEBPAGINA
# ============================================

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

# ============================================
# SERVICES STARTEN
# ============================================

log_info "Services starten..."
systemctl daemon-reload
systemctl enable networking dnsmasq tftpd-hpa nfs-kernel-server nginx
systemctl restart dnsmasq tftpd-hpa nfs-kernel-server nginx

# ============================================
# SERVICE STATUS CHECK
# ============================================

echo ""
log_info "Service status:"
for svc in dnsmasq tftpd-hpa nfs-kernel-server nginx; do
    if systemctl is-active --quiet $svc; then
        echo "  ✓ $svc"
    else
        echo "  ✗ $svc"
    fi
done

# ============================================
# EINDBERICHT
# ============================================

echo ""
echo "=========================================="
log_info "INSTALLATIE VOLTOOID"
echo "=========================================="
echo "WAN (internet): ${WAN_IF} -> router (192.168.178.1)"
echo "LAN (netboot):  ${LAN_IF} -> switch -> PXE-clients"
echo "Server IP:      ${LAN_IP}"
echo "Web interface:  http://${LAN_IP}"
echo ""
echo "BELANGRIJK: De switch met PXE-clients mag"
echo "NIET verbonden zijn met jouw router!"
echo "=========================================="