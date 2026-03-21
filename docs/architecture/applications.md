# Applicatie Architectuur

## Deployment Model

Alle applicaties draaien als Docker containers, georkestreerd door Kubernetes of Docker Swarm.


## Applicatie Categorieën

| Categorie | Aantal | Voorbeelden |
|-----------|--------|-------------|
| Databases | 20+ | PostgreSQL, MySQL, Redis, MongoDB |
| AI/LLM | 25+ | Ollama, LocalAI, JupyterHub, MLflow |
| Media | 25+ | Jellyfin, Plex, Immich, Radarr, Sonarr |
| Monitoring | 20+ | Prometheus, Grafana, Loki, Tempo |
| Security | 20+ | Vault, Bitwarden, Wazuh, TheHive |
| CMS/E-commerce | 15+ | WordPress, WooCommerce, Ghost, Strapi |
| ERP/CRM | 15+ | Odoo, ERPNext, SuiteCRM, EspoCRM |
| Collaboration | 15+ | Nextcloud, Mattermost, RocketChat |

## Stack Definitie

Elke applicatie heeft een YAML definitie in `applications/definitions/`:

```yaml
application:
  name: nextcloud
  version: 28.0.2
  container:
    image: nextcloud:28-fpm-alpine
  network_requirements:
    ports:
      - container: 80
        host: 8080
  hardware_requirements:
    storage:
      - name: data
        size_gb: 500
