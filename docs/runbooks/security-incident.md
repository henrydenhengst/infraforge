# Security Incident - Runbook

## Detectie
- Security alert (Wazuh / Falco)
- Ongeautoriseerde toegang
- Verdachte activiteit

## Impact
- Mogelijke data breach
- Ongeautoriseerde toegang tot systemen

## Prioriteit: P0 - Kritiek

## Stappen

### 1. Isolatie
- Blokkeer netwerkverkeer
- Stop kritieke services
- Revoke SSH keys

### 2. Forensische analyse
- Verzamel logs
- Check processen
- Maak disk image

### 3. Wachtwoorden wijzigen
- Alle gebruikers
- Database
- Applicaties

### 4. Herstel van backup
- Zie backup-restore.md

### 5. Root cause analyse
- Hoe is inbraak gebeurd?
- Welke data is getroffen?

## Escalatie
- Security team
- Management
- Autoriteiten (indien verplicht)