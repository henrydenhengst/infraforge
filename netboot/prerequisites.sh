#!/bin/bash
# netboot-prerequisites.sh
# Post-install script voor Devuan headless netboot-server
# Uitvoeren als root na een minimale Devuan installatie

set -e  # Stop bij fouten

# Kleuren voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Controleer of script als root draait
if [ "$EUID" -ne 0 ]; then 
    log_error "Dit script moet als root worden uitgevoerd (sudo)"
    exit 1
fi

# Detecteer actieve NICs (niet-loopback)
log_info "Beschikbare netwerkinterfaces:"
ip link show | grep -v lo | grep -E '^[0-9]+:' | cut -d: -f2
echo ""

# Vraag NICs voor WAN en LAN
read -p "Voer de WAN/management interface naam in (bv. enp0s3): " WAN_IF
read -p "Voer de Netboot/LAN interface naam in (bv. enp0s8): " LAN_IF
read -p "Voer het IP-adres voor de Netboot interface in (bv. 192.168.100.1): " LAN_IP
read -p "Voer het subnetmasker in (bv. 24 voor /24): " LAN_MASK

# Bereken CIDR notation
LAN_CIDR="${LAN_IP}/${LAN_MASK}"

log_info "Configureren systeem en packages..."
# Update package repositories
apt update

# Upgrade systeem (optioneel, maar aanbevolen)
log_info "Upgraden systeem (dit kan even duren)..."
apt upgrade -y

# Installeer basis tools en netboot benodigdheden
log_info "Installeren Netboot prerequisites..."
apt install -y \
    dnsmasq \
    tftpd-hpa \
    nfs-kernel-server \
    nginx-light \
    wget \
    curl \
    unzip \
    vim \
    net-tools \
    bridge-utils \
    htop

# Stop services die we nog gaan configureren
systemctl stop dnsmasq tftpd-hpa nginx 2>/dev/null || true

# Maak directory structuur
log_info "Aanmaken directory structuur..."
mkdir -p /srv/tftp /srv/nfs /var/www/netboot
mkdir -p /srv/netboot/{images,isos,menus}

# Download netboot.xyz bestanden
log_info "Downloaden netboot.xyz bootloaders..."
cd /srv/tftp
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz.efi
wget -q --show-progress https://boot.netboot.xyz/ipxe/netboot.xyz-arm64.efi

chmod 644 /srv/tftp/*

# Download Devuan netboot image (Devuan 6.0 excalibur)
log_info "Downloaden Devuan netboot image (6.0 excalibur)..."
DEVUAN_MIRROR="https://deb.devuan.org/devuan/dists/excalibur/main/installer-amd64/current/images/netboot"
cd /tmp
wget -q --show-progress "${DEVUAN_MIRROR}/netboot.tar.gz" || {
    log_warn "Kon Devuan netboot niet downloaden, probeer alternatieve mirror..."
    DEVUAN_MIRROR="https://mirror.dogado.de/devuan/devuan/dists/excalibur/main/installer-amd64/current/images/netboot"
    wget -q --show-progress "${DEVUAN_MIRROR}/netboot.tar.gz"
}
tar -xzf netboot.tar.gz -C /srv/tftp/
rm -f netboot.tar.gz

log_info "Downloaden Debian netboot (fallback)..."
wget -q --show-progress https://deb.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/netboot.tar.gz -O /tmp/debian-netboot.tar.gz
tar -xzf /tmp/debian-netboot.tar.gz -C /srv/tftp/debian/
rm -f /tmp/debian-netboot.tar.gz

# Configureer statisch IP voor Netboot interface
log_info "Configureren statisch IP voor ${LAN_IF}..."
cat > /etc/network/interfaces.d/${LAN_IF} << EOF
auto ${LAN_IF}
iface ${LAN_IF} inet static
    address ${LAN_IP}
    netmask ${LAN_MASK}
EOF

# Configureer dnsmasq voor DHCP + TFTP
log_info "Configureren dnsmasq voor Netboot netwerk..."
BACKUP_SUFFIX=".backup.$(date +%Y%m%d_%H%M%S)"
[ -f /etc/dnsmasq.conf ] && cp /etc/dnsmasq.conf /etc/dnsmasq.conf${BACKUP_SUFFIX}

cat > /etc/dnsmasq.conf << EOF
# Netboot DHCP/TFTP configuratie
# Alleen actief op de Netboot interface
interface=${LAN_IF}
bind-interfaces
dhcp-range=${LAN_IP%.*}.50,${LAN_IP%.*}.200,12h
dhcp-option=option:router,${LAN_IP}
dhcp-option=option:dns-server,8.8.8.8,8.8.4.4

# TFTP root directory
enable-tftp
tftp-root=/srv/tftp

# PXE boot configuratie
# Legacy BIOS
dhcp-match=set:bios,60,PXEClient:Arch:00000
dhcp-boot=tag:bios,netboot.xyz.kpxe

# UEFI 64-bit
dhcp-match=set:efi64,60,PXEClient:Arch:00007
dhcp-boot=tag:efi64,netboot.xyz.efi

# UEFI 32-bit
dhcp-match=set:efi32,60,PXEClient:Arch:00006
dhcp-boot=tag:efi32,netboot.xyz.efi

# BIOS via UEFI (fallback)
dhcp-boot=netboot.xyz.kpxe

# Logging
log-dhcp
log-queries
EOF

# Configureer tftpd-hpa
log_info "Configureren tftpd-hpa..."
cat > /etc/default/tftpd-hpa << EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure --create"
EOF

# Configureer NFS exports
log_info "Configureren NFS shares..."
cat > /etc/exports << EOF
/srv/nfs ${LAN_IP%.*}.0/${LAN_MASK}(rw,sync,no_subtree_check,no_root_squash)
/srv/tftp ${LAN_IP%.*}.0/${LAN_MASK}(ro,sync,no_subtree_check)
EOF

# Configureer nginx voor HTTP netboot
log_info "Configureren nginx..."
cat > /etc/nginx/sites-available/netboot << EOF
server {
    listen 80;
    server_name _;
    
    root /var/www/netboot;
    index index.html;
    
    location / {
        autoindex on;
    }
    
    location /tftp {
        alias /srv/tftp;
        autoindex on;
    }
    
    location /nfs {
        alias /srv/nfs;
        autoindex on;
    }
}
EOF

ln -sf /etc/nginx/sites-available/netboot /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Start services
log_info "Starten services..."
systemctl enable networking dnsmasq tftpd-hpa nfs-kernel-server nginx
systemctl restart dnsmasq tftpd-hpa nfs-kernel-server nginx

# Maak een eenvoudige status webpagina
cat > /var/www/netboot/index.html << EOF
<!DOCTYPE html>
<html>
<head><title>Netboot Server Status</title></head>
<body>
<h1>Netboot Server - Devuan Headless</h1>
<p>Server is actief!</p>
<ul>
    <li><a href="/tftp/">TFTP Bestanden</a> (Netboot loaders)</li>
    <li><a href="/nfs/">NFS Shares</a></li>
</ul>
<h2>Actieve clients</h2>
<pre>$(journalctl -u dnsmasq -n 50 --no-pager | grep "DHCPACK" || echo "Geen recente DHCP leases")</pre>
</body>
</html>
EOF

# Log firewall suggesties
log_info "Firewall configuratie suggestie (indien ufw of iptables actief):"
cat << EOF
Indien je een firewall gebruikt, zorg dat deze poorten open zijn:
  - UDP 67,68 (DHCP)
  - UDP 69 (TFTP)
  - TCP 80 (HTTP)
  - TCP/UDP 111,2049 (NFS)
  - UDP 4011 (iPXE proxyDHCP)

Voorbeeld met iptables:
iptables -A INPUT -i ${LAN_IF} -p udp --dport 67:68 -j ACCEPT
iptables -A INPUT -i ${LAN_IF} -p udp --dport 69 -j ACCEPT
iptables -A INPUT -i ${LAN_IF} -p tcp --dport 80 -j ACCEPT
EOF

# Toon overzicht
log_info "Devuan Netboot Server installatie voltooid!"
echo ""
echo "=========================================="
echo "CONFIGURATIE OVERZICHT:"
echo "=========================================="
echo "WAN Interface (management): ${WAN_IF}"
echo "LAN Interface (netboot): ${LAN_IF}"
echo "Netboot IP: ${LAN_IP}"
echo "DHCP range: ${LAN_IP%.*}.50 - ${LAN_IP%.*}.200"
echo ""
echo "Services status:"
systemctl is-active dnsmasq && echo "  ✓ dnsmasq (DHCP/TFTP)" || echo "  ✗ dnsmasq"
systemctl is-active tftpd-hpa && echo "  ✓ tftpd-hpa" || echo "  ✗ tftpd-hpa"
systemctl is-active nfs-kernel-server && echo "  ✓ NFS" || echo "  ✗ NFS"
systemctl is-active nginx && echo "  ✓ nginx" || echo "  ✗ nginx"
echo ""
echo "Web interface: http://${LAN_IP}"
echo "=========================================="
echo ""
log_warn "Herstart de server om alle configuraties te activeren: reboot"