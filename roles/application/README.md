# Application Role

## Beschrijving
Deze role deployt Docker containers op basis van stack definities.

## Wat doet deze role?
- Installeert Docker Compose en Python Docker module
- Maakt applicatie directories aan
- Maakt Docker netwerken aan
- Deploy applicatie stacks op basis van YAML definities
- Configureert reverse proxy (Nginx, Traefik)
- Configureert monitoring (Prometheus targets)
- Valideert applicatie status

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| apps_to_deploy | [] | Lijst van applicaties om te deployen |
| docker_networks | default | Docker netwerken om aan te maken |
| configure_proxy | true | Reverse proxy configureren |
| proxy_type | nginx | Type reverse proxy |
| monitoring_enabled | true | Monitoring configureren |
| backup_enabled | true | Backups configureren |
| environment | production | Omgeving (prod/staging/dev) |
| domain | company.local | Domein naam |

## Applicatie definitie
Elke applicatie heeft een YAML bestand in `applications/definitions/` met:
- `application.name` - Naam van de applicatie
- `application.version` - Versie
- `application.container.image` - Docker image
- `application.network_requirements` - Netwerk configuratie
- `application.hardware_requirements` - Storage vereisten
- `application.environment_variables` - Omgevingsvariabelen
- `application.health_checks` - Health check configuratie

## Tags
- `prerequisites` - Alleen prerequisites installeren
- `directories` - Alleen directories aanmaken
- `networks` - Alleen Docker netwerken aanmaken
- `deploy` - Alleen applicatie deployen
- `proxy` - Alleen reverse proxy configureren
- `monitoring` - Alleen monitoring configureren
- `validate` - Alleen validatie
