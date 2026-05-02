# Linux Café Haarlem Server Deployment

Deze repository bevat de Ansible-configuratie voor de website en infrastructuur van het Linux Café Haarlem op Void Linux.

## Systeemoverzicht
- **Webserver:** Caddy (automatische SSL via DuckDNS/Let's Encrypt)
- **CMS:** Grav (Flat-file, PHP 8.3)
- **OS:** Void Linux met Runit service management
- **Security:** UFW, SSH-hardening, Fail2ban

## Gebruik
1. Zorg voor een werkende Void Linux server met SSH-toegang.
2. Kopieer `secret.example.yml` naar `secret.yml` en vul de tokens in.
3. Start de uitrol:
   ```bash
   ansible-playbook -i inventory.ini site.yml
