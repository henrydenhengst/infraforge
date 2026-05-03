# Mijn Ansible Configuratie Voorkeuren

## Basis Methodiek

- Ansible als Configuration Management (geen deployment tool)
- Idempotent: playbook kan altijd opnieuw gedraaid worden
- Single Source of Truth: gewenste staat staat in code
- Draait op localhost (niet remote via SSH)
- Geen SSH keys, geen inventory.yml, geen deploy scripts

## Infrastructuur

- Localhost only
- Kleine schaal (max 25 gebruikers)
- Geen load balancing of clustering
- VPS met beperkte resources is voldoende

## Security Verwachtingen

- OS security: SSH hardening, UFW firewall, Fail2ban
- Application security: least privilege, secure headers, expose_php=Off
- Secrets in ansible-vault
- Geen mail verzending

## Applicatie Eisen

- **Grav CMS** met admin panel
- **Mattermost** inclusief **PostgreSQL** database
- Geen mail server nodig
- Mail ontvangst via Duck.com forwarding
- Gebruikers handmatig toevoegen (uitnodiging via Signal/WhatsApp)
- Geen SMTP configuratie

## Compleetheid

Ik verwacht dat het playbook **alles** installeert en configureert:

- ✅ Alle pakketten (Caddy, PHP-FPM, Grav, Mattermost, PostgreSQL)
- ✅ Alle dependencies (PHP extensies, PostgreSQL contrib, etc)
- ✅ Alle services (Runit links, starten/enablen)
- ✅ Alle configuraties (Caddyfile, PHP-FPM pool, Mattermost config)
- ✅ Alle security (SSH, UFW, Fail2ban, headers)
- ✅ Alle monitoring (health checks, logrotate)

## Wat ik NIET wil

❌ Remote SSH deployments
❌ Inventory bestanden
❌ Mail verzending / SMTP
❌ Complexe deploy pipelines
❌ Overbodige scripts (deploy.sh, test.sh)
❌ Docker (tenzij specifiek gevraagd)
❌ Handmatige stappen na het playbook

## Wat ik WEL wil

✅ Simpele, idempotente playbooks
✅ Templates voor configuraties
✅ Vault voor geheimen
✅ Minimale bestandset (site.yml, vars.yml, secret.yml, requirements.yml, templates/)
✅ Heldere README met instructies
✅ Handlers voor service management
✅ OS hardening out-of-the-box
✅ Application security by default

## Standaard Stack

| Component | Versie | Configuratie |
|-----------|--------|--------------|
| Caddy | latest | Automatisch HTTPS, security headers |
| PHP-FPM | 8.2+ | _caddy user, geoptimaliseerd voor Grav |
| PostgreSQL | latest | Dedicated mattermost user/database |
| Mattermost | 9.5+ | Geen mail, localhost only |
| Grav | latest | Admin panel, _caddy ownership |
| UFW | - | Alleen poort 22,80,443 |
| Fail2ban | - | SSH protectie, bantime 3600 |

## Standaard Workflow

```bash
git clone <repo>
cd project
ansible-galaxy collection install -r requirements.yml
cp secret.example.yml secret.yml
ansible-vault encrypt secret.yml
sudo ansible-playbook site.yml --ask-vault-pass