# Linux Café Haarlem - Ansible Deployment

## 📋 Overzicht
Dit Ansible playbook installeert en configureert automatisch een productie-webserver voor Linux Café Haarlem op **Void Linux**.

## 🎯 Features
- ✅ **Caddy webserver** met automatische HTTPS
- ✅ **Grav CMS** met admin panel
- ✅ **PHP-FPM** geoptimaliseerd voor Grav
- ✅ **DuckDNS** dynamisch DNS
- ✅ **Fail2ban** SSH brute-force protectie
- ✅ **UFW firewall** strict policy
- ✅ **Logrotate** log management
- ✅ **Health checks** monitoring
- ✅ **Mattermost** ready (optioneel, zonder mail)

## 📧 Mail Configuratie
- **Ontvangen**: Via Duck.com forwarding naar `vcp5693@duck.com`
- **Verzenden**: Niet geconfigureerd (niet nodig voor deze setup)

## 📦 Vereisten

### Control node (waar Ansible draait)
- Ansible 2.9+
- Python 3.6+
- `community.general` collection

### Target host (Void Linux server)
- Void Linux (glibc)
- SSH toegang met pubkey
- Minimaal 1GB RAM
- 10GB vrije schijfruimte

## 🚀 Snelle start

```bash
# 1. Clone repository
git clone https://github.com/henrydenhengst/linuxcafehaarlem.git
cd linuxcafehaarlem

# 2. Configureer variabelen
nano vars.yml
cp secret.example.yml secret.yml
nano secret.yml

# 3. Versleutel geheimen
ansible-vault encrypt secret.yml

# 4. Configureer inventory
nano inventory.yml

# 5. Run deployment
chmod +x deploy.sh
./deploy.sh
```