# New Server - Runbook

## Stappen

1. **Voeg toe aan inventory**
   vim inventory/production/hosts.ini

2. **Test connectiviteit**
   ansible -i inventory/production/hosts.ini nieuwe-server -m ping

3. **Configureer**
   ansible-playbook -i inventory/production/hosts.ini playbooks/site.yml --limit nieuwe-server

4. **Controleer**
   ansible nieuwe-server -m shell -a "docker ps"