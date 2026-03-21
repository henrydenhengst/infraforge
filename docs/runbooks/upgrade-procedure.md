# Upgrade Procedure - Runbook

## Planning
- Security updates: Direct
- Minor updates: Wekelijks
- Major updates: Maandelijks

## Stappen

### 1. Pre-upgrade
- Check disk space
- Check backups
- Maak snapshot

### 2. Staging test
- Dry-run
- Volledige upgrade
- Valideer

### 3. Productie (rolling)
- Per server upgraden
- Na elke server testen

### 4. Valideer
- Controleer versies
- Controleer services
- Controleer monitoring

### 5. Rollback (indien nodig)
- Herstel packages
- Herstel snapshot

## Commando's

### Security upgrade
ansible-playbook playbooks/upgrade.yml -e upgrade_type=security

### Alle packages
ansible-playbook playbooks/upgrade.yml -e upgrade_type=all

### Alleen Docker containers
ansible-playbook playbooks/upgrade.yml -e upgrade_type=apps