# ADR-0006: Applicatie deployment strategie

## Status
Geaccepteerd

## Context
We moeten applicaties consistent kunnen deployen, updaten en verwijderen.

## Beslissing
Elke applicatie heeft een YAML definitie in `applications/definitions/` met:
- Docker image en tag
- Poort mappings
- Volume mounts
- Environment variabelen
- Health checks
- Resources (CPU, memory)

Deployment via de `application` role die:
1. Docker Compose bestand genereert
2. Container(s) start
3. Health check uitvoert
4. Monitoring configureert

## Motivering
- **Consistentie** - Alle apps op dezelfde manier gedeployed
- **Herbruikbaarheid** - Eén role voor alle apps
- **Documentatie** - YAML is leesbaar
- **Versiebeheer** - Alle definities in Git

## Gevolgen
- Eenvoudig toevoegen van nieuwe apps
- Consistente structuur
- Makkelijk terugdraaien van wijzigingen

## Alternatieven overwogen
- **Helm charts** - Te complex voor simpele apps
- **Kustomize** - Meer voor Kubernetes
- **Handmatig** - Foutgevoelig