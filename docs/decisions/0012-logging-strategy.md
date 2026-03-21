# ADR-0005: Docker als container runtime

## Status
Geaccepteerd

## Context
We hebben een container runtime nodig voor applicatie isolatie en deployment.

## Beslissing
We gebruiken **Docker Engine** als primaire container runtime, met containerd als fallback.

## Motivering
- **Marktstandaard** - Meest gebruikte container runtime
- **Ecosysteem** - Grote community, veel tools
- **Docker Compose** - Eenvoudige multi-container applicaties
- **Docker Swarm** - Optionele orchestratie
- **Kubernetes compatibel** - Werkt met containerd

## Gevolgen
- Docker images zijn de standaard
- Docker Compose voor applicatie definities
- Eenvoudige deployment voor developers

## Alternatieven overwogen
- **Podman** - Daemonless, maar minder geïntegreerd
- **CRI-O** - Meer voor Kubernetes alleen
- **rkt** - Niet meer actief ontwikkeld