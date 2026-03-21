# FAQ

V: Hoe voeg ik een nieuwe server toe?
A: Voeg server toe aan inventory/production/hosts.ini en draai:
   ansible-playbook -i inventory/production/hosts.ini playbooks/site.yml --limit nieuwe-server

V: Hoe update ik een bestaande applicatie?
A: Pas de image tag aan in applications/definitions/app.yml en draai:
   ansible-playbook playbooks/deploy-app.yml -e app_name=app

V: Hoe maak ik een backup van een database?
A: ansible-playbook playbooks/backup.yml -e backup_type=daily

V: Hoe herstel ik een database?
A: ansible-playbook playbooks/emergency.yml -e emergency_type=restore_db

V: Hoe debug ik een mislukte task?
A: ansible-playbook playbooks/site.yml -vvv
