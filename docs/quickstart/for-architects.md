# Voor Architects

## Structuur

- inventory/                 - Wat heb je?
  - production/              - Productie omgeving
    - hosts.ini              - Server lijst
    - group_vars/            - Variabelen per groep
    - host_vars/             - Variabelen per server
- roles/                     - Herbruikbare bouwstenen (70+)
- playbooks/                 - Orchestratie (7)
- applications/definitions/  - 300+ Docker containers

## Hoe voeg ik een nieuwe role toe?

1. mkdir -p roles/nieuwe-role/{tasks,handlers,vars,defaults,templates,meta,files}
2. Schrijf tasks/main.yml
3. Voeg role toe aan playbooks/site.yml

## Best practices

1. Gebruik tags voor gerichte uitvoering
2. Documenteer variabelen in defaults/main.yml
3. Test met Molecule voor elke role
4. Gebruik ansible-vault voor secrets
