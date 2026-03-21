# Monitoring Role

## Beschrijving
Deze role installeert en configureert een complete monitoring stack:
- **Prometheus** - Metrics verzameling
- **Grafana** - Dashboards en visualisatie
- **Loki** - Log aggregatie
- **Promtail** - Log collector
- **Node Exporter** - Systeem metrics
- **cAdvisor** - Container metrics
- **Alertmanager** - Alerting

## Wat doet deze role?
- Installeert Prometheus, Grafana, Loki, Promtail, Node Exporter, cAdvisor en Alertmanager
- Configureert scraping van metrics
- Configureert Grafana datasources en dashboards
- Configureert log verzameling met Promtail
- Configureert alerting regels
- Valideert of alle services draaien

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| prometheus_version | 2.48.0 | Prometheus versie |
| grafana_version | 10.2.3 | Grafana versie |
| loki_version | 2.9.4 | Loki versie |
| prometheus_scrape_interval | 30s | Scrape interval |
| prometheus_retention_days | 30 | Retention periode |
| grafana_admin_password | vault_grafana_password | Grafana admin wachtwoord |

## Tags
- `prerequisites` - Alleen prerequisites installeren
- `node_exporter` - Alleen Node Exporter
- `cadvisor` - Alleen cAdvisor
- `prometheus` - Alleen Prometheus
- `grafana` - Alleen Grafana
- `loki` - Alleen Loki
- `promtail` - Alleen Promtail
- `alertmanager` - Alleen Alertmanager
- `validate` - Alleen validatie
