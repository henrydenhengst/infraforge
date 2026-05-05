# Mijn SERVER Ansible Configuratie Voorkeuren

## AI Assistent Workflow (Runit/OpenRC Editie)

### Kernregel
Systemd is niet toegestaan. Geen uitzonderingen.
Toegestaan: Runit (Void) en OpenRC (Devuan).

### OS Keuze
Stap 1: Default = Void Linux
Stap 2: Devuan als workaround als:
- Package niet in Void repos
- Ik niet de enige beheerder ben
- Technische problemen met Void

### Wat niet mag
Distributies met systemd: Debian, Ubuntu, Fedora, RHEL, Arch, etc.

### Fase 1: Advies (geen code)

1. OS Keuze Check
- Software in Void repos? Ja -> Void
- Nee -> bestaat alternatief in Void? Nee -> Devuan
- Heeft Devuan ook systemd nodig? Stop.

2. Init System Compatibiliteit
- Runit (Void): /etc/sv/*/run, svlogd, cron
- OpenRC (Devuan): /etc/init.d/, syslog, cron

3. Systemd Block Check
- systemd als PID 1 -> Stop
- socket-activatie -> Stop
- systemd --user -> Stop
- systemd-timers -> vervang door cron
- systemd-journald -> log naar files

4. Overige checks
- Past binnen 25 gebruikers op mini-pc?
- Hidden costs, extra poorten?
- Mail blokkeren in config?
- Database groei, backup plan?
- Trade-offs duidelijk?

### Fase 2: Go/No Go
- Go -> AI schrijft playbooks
- Pas aan -> AI herziet advies
- Stop -> Project gaat niet door

Stop melding:
STOP - Project gaat niet door
Applicatie: [naam]
Reden: [systemd dependency]
Alternatieven: [lijst]

### Fase 3: Code (alleen na groen licht)

Wat NIET mag:
- Geen mail/SMTP
- Geen remote SSH
- Geen inventory
- Geen systemd
- Geen handmatige stappen

Wat WEL mag:
- Idempotente playbooks
- Templates
- Vault voor geheimen
- Handlers
- Runit of OpenRC scripts

Runit template (Void):
/etc/sv/[service]/run
#!/bin/sh
exec 2>&1
exec chpst -u [user]:[group] [command]

Activeren: ln -s /etc/sv/[service] /var/service/

OpenRC template (Devuan):
/etc/init.d/[service]
#!/sbin/openrc-run
name="[service]"
command="[command]"
command_user="[user]"

Activeren: rc-update add [service] default

### Samenvatting voor AI
- Systemd voorstellen? Nee.
- Devuan voorstellen? Ja, als workaround.
- Applicatie heeft systemd nodig? Stop.
- Runit scripts? Ja, voor Void.
- OpenRC scripts? Ja, voor Devuan.

---

## Basis Methodiek
- Ansible als Configuration Management (geen deployment tool)
- Idempotent: playbook kan altijd opnieuw gedraaid worden
- Single Source of Truth: gewenste staat staat in code
- Draait op localhost (niet remote via SSH)
- Geen SSH keys, geen inventory.yml, geen deploy scripts

## Infrastructuur
- Localhost only
- Geen load balancing of clustering
- (Mini) pc met beperkte resources is voldoende

## Hardware & Optimalisatie

### Processor & Stabiliteit
- Microcode Updates: intel-microcode en amd64-microcode
- Thermisch Beheer: thermald

### Opslag & Randapparatuur
- Cross-Platform Storage: NTFS en exFAT
- Smartcard Support: pcscd en opensc

### Optimalisatie
- CPU: cpupower governor performance
- Memory: Geen zram, swap op schijf
- SSD: Trim, noatime, discard
- Energie: Geen besparingen (vaste netstroom)

### Containers (optioneel)
- Docker indien nodig (geen Podman)
- Alleen als install_docker: true in vars.yml
- Rootless mode, log limieten (10m/3 files)
- Resource limits: memory 512m, cpus 0.5
- Geen swap voor containers, overlay2 driver
- Live restore, wekelijks docker system prune

## Security Verwachtingen
- OS: SSH hardening, UFW firewall, Fail2ban
- Application: least privilege, secure headers, expose_php=Off
- Secrets in ansible-vault
- Geen mail verzending

## Backup (standaard)

### Uitgangspunt
- Backups zijn verplicht voor elke applicatie
- Backup locatie: USB disk (permanent aangesloten)
- Formaat: ext4
- Geen encryptie (KISS)
- Frequentie: dagelijks (via cron)
- Bewaartermijn: 30 dagen (rotatie)

### USB disk & udev
- Disk wordt herkend via UUID
- Mount punt: /mnt/backup
- fstab: UUID=[UUID] /mnt/backup ext4 defaults,nofail 0 0
- Rechten: backup:backup

### Backup structuur
/mnt/backup/[appnaam]/
  daily.0/ (meest recent)
  daily.1/
  ...
  daily.30/

### Backup scripts
- /usr/local/bin/backup-[appnaam].sh per applicatie
- /etc/cron.daily/backup-all (centrale cron)
- Logging: /var/log/backup.log

### Wat NIET in backup
- /proc, /sys, /dev
- /tmp, cache directories
- Logs (logrotate beheert die)

### Restore
- cp -r /mnt/backup/[appnaam]/daily.0/* /destination/
- Database: psql/pg_restore of mysql

## Applicatie Eisen
- Geen mail server
- Mail ontvangst via Duck.com forwarding
- Gebruikers handmatig toevoegen (Signal/WhatsApp)
- Geen SMTP configuratie

## OS Keuze: Void tenzij Devuan

### Void Linux (Default)
- Runit (simpeler dan systemd)
- Xbps (snel en clean)
- Minimale overhead
- Rolling release

### TCP/IP
- Zoek interface naam
- static IP: 192.168.178.2/24
- gateway: 192.168.178.1
- dns: 9.9.9.9 1.1.1.1 8.8.8.8

### Devuan (workaround)
Stap over als:
1. Package niet in Void repos
2. Ik niet de enige beheerder ben
3. Technische problemen

## Compleetheid
Playbook installeert en configureert:
- Alle pakketten en dependencies
- Alle services (Runit links, start/enable)
- Alle configuraties
- Alle security
- Alle monitoring
- Alle backups (udev, scripts, cron)

## Wat ik NIET wil
- Remote SSH deployments
- Inventory bestanden
- Mail verzending / SMTP
- Complexe deploy pipelines
- Overbodige scripts
- Handmatige stappen na playbook

## Wat ik WEL wil
- Simpele, idempotente playbooks
- Templates voor configuraties
- Vault voor geheimen
- Minimale bestandset
- Handlers voor service management
- OS hardening out-of-the-box
- Application security by default

## README.md 

### Inhoudelijke vereisten
- Projectnaam + badges
- Beschrijving + features
- Installatie + Gebruik
- Configuratie + Hoe het werkt
- Vereisten
- Contributing + MIT License
- Status

### Technische vereisten
- Output uitsluitend als raw Markdown in één enkel codeblock.
- Geen uitleg buiten het codeblock.
- Geen extra commentaar, geen preamble, geen afsluiting.
- Gebruik GitHub-flavored Markdown.
- Houd regels kort en vermijd onnodig lange regels.
- Gebruik duidelijke headings, bullets en tabellen waar nuttig.
- Maak de structuur logisch, technisch en overzichtelijk.
- Zorg dat alles direct kopieerbaar is zonder opmaakfouten.
- Gebruik geen HTML tenzij strikt noodzakelijk.
- Gebruik geen horizontale lijnen tenzij echt nuttig.
- Zet codevoorbeelden in aparte fenced codeblocks.
- Als iets onduidelijk is, stel eerst maximaal 3 gerichte vragen.
- korte regels;
- compacte bullets;
- zo min mogelijk tabellen;
- code alleen in echte fenced blocks;
- geen lange alinea’s die over je scherm lopen

## Standaard Stack
- Caddy latest (HTTPS, security headers)
- PHP-FPM 8.2+
- UFW (poort 22,80,443)
- Fail2ban (SSH protectie, bantime 3600)

## Standaard Workflow
git clone <repo>
cd project
ansible-galaxy collection install -r requirements.yml
cp secret.example.yml secret.yml
ansible-vault encrypt secret.yml
sudo ansible-playbook site.yml --ask-vault-pass

## Wat ik verwacht van de assistent
- Geen remote SSH oplossingen
- Geen mail verzending
- Ga uit van Void, tenzij ik Devuan specificeer
- Houd het simpel
- Vraag naar schaal/gebruikers als relevant

---

# Opdracht Specificatie

## 1. Doel
[Installeer en configureer APP_NAAM op een Void mini-pc]

## 2. Te installeren componenten
- [APP_NAAM] (versie)
- [DATABASE]
- [WEBSERVER]
- [ANDERE DEPENDENCIES]

## 3. Bereikbaarheid
- [Alleen LAN / Publiek]
- Domein: [app.lan]

## 4. Netwerk
[Zelfde als baseline / Afwijking: interface, IP, gateway, DNS]

## 5. Gebruik & schaal
- Aantal gebruikers: [getal]
- Verwacht gebruik: [licht/gemiddeld/intensief]

## 6. Data & opslag
- Data pad: [/pad/naar/data]
- Backups: [default baseline / afwijking]

## 7. Containers
- [Wel/Niet] Docker gebruiken

## 8. Security (aanvullend)
[Baseline voldoende / extra poorten / extra fail2ban]

## 9. Verwachte output
- Volledige Ansible structuur
- Alle configuraties
- Werkend zonder handmatige stappen
- Idempotent
- Void + Runit compatible

## 10. Beperkingen (hard constraints)
- Geen remote SSH
- Geen mail/SMTP
- Geen inventory
- Geen handmatige stappen
- Void als uitgangspunt