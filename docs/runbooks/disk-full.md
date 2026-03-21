# Server Down - Runbook

## Detectie
- Server niet bereikbaar
- Monitoring alert

## Stappen

1. **Controleer of server bereikbaar is**
   ping server.company.local

2. **Probeer SSH**
   ssh ansible@server.company.local

3. **Herstart via IPMI**
   ipmitool -H 10.10.100.11 -U admin power cycle

4. **Herstel services**
   ansible-playbook -i inventory/production/hosts.ini playbooks/site.yml --limit server

5. **Controleer**
   ansible server -m ping