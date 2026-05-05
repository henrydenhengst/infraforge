# Mijn SERVER Ansible Configuratie Voorkeuren

## Basis Methodiek

- Ansible als Configuration Management (geen deployment tool)
- Idempotent: playbook kan altijd opnieuw gedraaid worden
- Single Source of Truth: gewenste staat staat in code
- Draait op localhost (niet remote via SSH)
- Geen SSH keys, geen inventory.yml, geen deploy scripts

## Infrastructuur

- Localhost only
- Geen load balancing of clustering
- VPS met beperkte resources is voldoende

## Hardware & Optimalisatie

### Processor & Stabiliteit
- **Microcode Updates:** Installeert zowel `intel-microcode` als `amd64-microcode` om beveiligingslekken en stabiliteitsfouten direct op de CPU te patchen.
- **Thermisch Beheer:** Activeert `thermald` om oververhitting en "throttelen" te voorkomen, geschikt voor mini-pc's met passieve of kleine actieve koeling.

### Opslag & Randapparatuur
- **Cross-Platform Storage:** Volledige lees- en schrijfondersteuning voor NTFS (externe schijven) en exFAT (USB-sticks/SD-kaarten).
- **Smartcard Support:** Activeert `pcscd` en `opensc` voor hardware-tokens, eID-lezers en authenticatiekaarten.

### Optimalisatie voor CPU, Memory en Energieverbruik

| Component | Optimalisatie |
|-----------|----------------|
| **CPU**   | Prestatieprofiel via `cpupower` (governor: `performance` voor vaste netstroom) |
| **Memory**| **Geen zram** – swap op schijf heeft de voorkeur voor stabiliteit bij een mini-pc |
| **SSD**   | Trim actief (`fstrim.timer`), `noatime` mount-optie, `discard` asynchroon |
| **Energie**| Geen energiebesparingen; mini-pc draait altijd op netstroom |

### Containers (optioneel)
- **Docker indien nodig** (geen Podman). Installatie alleen als variabele `install_docker: true` in `vars.yml`.
- Containers draaien in **gebruikersnamespace** waar mogelijk (rootless).

## Security Verwachtingen

- OS security: SSH hardening, UFW firewall, Fail2ban
- Application security: least privilege, secure headers, expose_php=Off
- Secrets in ansible-vault
- Geen mail verzending

## Applicatie Eisen

- Geen mail server gewenst
- Mail ontvangst via Duck.com forwarding
- Gebruikers handmatig toevoegen (uitnodiging via Signal/WhatsApp)
- Geen SMTP configuratie

# OS Keuze Advies: Void tenzij Devuan

## Uitgangspunt

**Kies Void Linux, tenzij...**

## Void Linux (Default)

Void is de eerste keuze vanwege:
- Runit (simpeler dan systemd)
- Xbps (snel en clean)
- Minimale overhead
- Rolling release (altijd fresh)

## TCP/IP

Zoek de naam van de interface, gebruik de juiste naam.

- static IP: 192.168.178.2/24
- gateway: 192.168.178.1
- dns: 9.9.9.9 1.1.1.1 8.8.8.8

## Tenzij Devuan

**Stap over naar Devuan als:**

### 1. Package beschikbaarheid
- De benodigde software zit niet in Void repos

### 2. Team context
- Ik niet de enige beheerder ben

### 3. Technische problemen 
- Het technisch gezien een probleem is.

## Compleetheid

Ik verwacht dat het playbook **alles** installeert en configureert:

- ✅ Alle pakketten
- ✅ Alle dependencies (PHP extensies, PostgreSQL contrib, etc)
- ✅ Alle services (Runit links, starten/enablen)
- ✅ Alle configuraties (Caddyfile, PHP-FPM pool, Mattermost config)
- ✅ Alle security (SSH, UFW, Fail2ban, headers)
- ✅ Alle monitoring (health checks, logrotate)

## Wat ik NIET wil

- ❌ Remote SSH deployments
- ❌ Inventory bestanden
- ❌ Mail verzending / SMTP
- ❌ Complexe deploy pipelines
- ❌ Overbodige scripts
- ❌ Handmatige stappen na het playbook

## Wat ik WEL wil

- ✅ Simpele, idempotente playbooks
- ✅ Templates voor configuraties
- ✅ Vault voor geheimen
- ✅ Minimale bestandset (.gitignore, site.yml, vars.yml, secret.yml, requirements.yml, templates/)
- ✅ Handlers voor service management
- ✅ OS hardening out-of-the-box
- ✅ Application security by default

## Heldere README.md

- Projectnaam
- Relevante Badges
- Beschrijving
- Features
- Installatie
- Het Gebruik
- Configuratie
- Hoe het werkt
- Vereisten
- Contributing
- License MIT
- Status

## Standaard Stack

| Component | Versie | Configuratie |
|-----------|--------|--------------|
| Caddy | latest | Automatisch HTTPS, security headers |
| PHP-FPM | 8.2+ |
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
```

## Wat ik verwacht van de assistent

- Stel geen remote SSH oplossingen voor
- Stel geen mail verzending voor
- Ga uit van Void, tenzij ik Devuan specificeer
- Houd het simpel (geen over-engineered oplossingen)
- Vraag naar schaal/gebruikers als het relevant is