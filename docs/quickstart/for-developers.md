# Voor Developers

## Hoe voeg ik een nieuwe applicatie toe?

1. Maak een applicatie definitie:
   cp applications/definitions/stack-template.yml applications/definitions/mijn-app.yml

2. Pas de definitie aan met:
   - Naam, versie, beschrijving
   - Docker image
   - Poorten
   - Volumes
   - Environment variabelen

3. Test lokaal:
   docker-compose -f /opt/applications/mijn-app/docker-compose.yml up -d

4. Deploy via Ansible:
   ansible-playbook playbooks/deploy-app.yml -e app_name=mijn-app

## Hoe test ik een role?

cd roles/mijn-role
molecule test

## Hoe debug ik een playbook?

ansible-playbook playbooks/site.yml -vvv
