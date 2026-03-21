# ADR-0001: Ansible als configuratie management tool

## Status
Geaccepteerd

## Context
We hebben een tool nodig om onze infrastructuur te automatiseren. De opties zijn:
- Ansible (agentless, YAML)
- Puppet (agent-based, declaratief)
- Chef (agent-based, Ruby)
- SaltStack (agent-based, Python)
- Terraform (infrastructure as code)

## Beslissing
We kiezen voor **Ansible** als primaire configuratie management tool.

## Motivering
- **Agentless** - Geen extra software nodig op managed nodes
- **YAML syntax** - Laagdrempelig voor alle teamleden
- **Idempotent** - Kan meerdere keren draaien zonder bijwerkingen
- **Grote community** - Veel beschikbare roles en modules
- **Goede integratie** met Docker, Kubernetes, cloud providers
- **Push-based** - Directe controle over wanneer configuratie wordt toegepast

## Gevolgen
**Positief:**
- Snelle adoptie door team
- Weinig dependencies op managed nodes
- Goede documentatie en community support

**Negatief:**
- Prestatie kan achterblijven bij grote infrastructuren
- Geen ingebouwde rapportage zoals bij Puppet

## Alternatieven overwogen
- **Terraform**: Goed voor infrastructure provisioning, maar minder geschikt voor configuratie management
- **Puppet**: Krachtig maar complexer en vereist agents
- **Chef**: Flexibel maar steilere leercurve