# Voor Ops

## Hoe start ik een server?

1. Voeg server toe aan inventory:
   vim inventory/production/hosts.ini

2. Test connectiviteit:
   ansible -i inventory/production/hosts.ini nieuwe-server -m ping

3. Configureer de server:
   ansible-playbook -i inventory/production/hosts.ini playbooks/site.yml --limit nieuwe-server

## Hoe voer ik een backup uit?

ansible-playbook playbooks/backup.yml -e backup_type=daily

## Hoe upgrade ik het systeem?

ansible-playbook playbooks/upgrade.yml -e upgrade_type=security

## Hoe los ik een incident op?

ansible-playbook playbooks/emergency.yml -e emergency_type=restart
