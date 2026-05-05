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
- (mini) pc met beperkte resources is voldoende

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
- **Installatie** alleen als `install_docker: true` in `vars.yml`
- **Rootless mode** standaard ingeschakeld voor betere isolatie
- **Log limieten:** `max-size: 10m` en `max-file: 3` per container (voorkomt volgeschreven schijf)
- **Standaard resource limits:** `memory: 512m`, `cpus: 0.5` per container (aanpasbaar per service)
- **Geen swap** voor containers (forceert memory discipline)
- **Gebruikt `overlay2`** storage driver (stabiel en zuinig)
- **Live restore** ingeschakeld (containers blijven draaien bij Docker herstart)
- **Automatisch opruimen:** `docker system prune -f` wekelijks via cron (tijdelijk: 24u, ongebruikt: 72u)

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

---

🧩 Opdracht Specificatie (Ansible Homelab)

1. Doel

Beschrijf in één of twee zinnen wat je wilt bereiken.
Bijvoorbeeld: het installeren en configureren van een specifieke applicatie of stack.

2. Te installeren componenten

Noem expliciet:

- Welke applicaties
- Welke ondersteunende diensten (database, webserver, etc.)

Wees concreet. Vermijd impliciete aannames.

3. Bereikbaarheid

Geef aan hoe de service bereikbaar moet zijn:

- Alleen lokaal netwerk (LAN)
- Of publiek via internet

Indien publiek:

- Vermeld of je een domein gebruikt (en welke)

4. Netwerk

Bevestig of je standaard netwerkconfig gebruikt of afwijkingen hebt:

- Interface naam
- Statisch IP
- Gateway en DNS

Alleen vermelden als het afwijkt van je baseline, anders impliciet akkoord.

5. Gebruik & schaal

Geef een realistische indicatie:

- Aantal gebruikers (ruwe schatting is voldoende)
- Verwacht gebruik (licht, gemiddeld, intensief)

6. Data & opslag

Beschrijf:

- Waar data opgeslagen moet worden (standaard pad of afwijking)
- Of persistentie belangrijk is (meestal wel)
- Of je backups verwacht (ja/nee, simpel/uitgebreid)

7. Containers (optioneel)

Geef expliciet aan:

- Of Docker gebruikt moet worden
- Of alles native op het OS draait

8. Security (aanvullend op baseline)

Alle extra eisen bovenop je standaard:

- Specifieke poorten
- Extra bescherming (bijv. extra fail2ban regels)
- Toegangsrestricties

Als niets extra’s nodig is: expliciet vermelden dat de baseline voldoende is.

9. Verwachte output

Beschrijf wat je concreet wilt ontvangen:

- Volledige Ansible structuur
- Alle configuraties inbegrepen
- Werkend zonder handmatige stappen
- Idempotent
- Passend binnen jouw baseline (Void, runit, localhost)

10. Beperkingen (hard constraints)

Herhaal expliciet wat niet mag afwijken:

- Geen remote SSH gebruik
- Geen mail/SMPP configuratie
- Geen inventory bestanden
- Geen handmatige stappen achteraf
- Void Linux als uitgangspunt

---
