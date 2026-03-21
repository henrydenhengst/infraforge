# ADR-0008: Monitoring stack

## Status
Geaccepteerd

## Context
We hebben monitoring nodig voor metrics, logs en traces.

## Beslissing
We gebruiken de **Grafana stack**:

| Component | Functie |
|-----------|---------|
| Prometheus | Metrics verzameling |
| Grafana | Visualisatie |
| Loki | Log aggregatie |
| Tempo | Distributed tracing |
| Alertmanager | Alerting |

## Motivering
- **Open source** - Geen licentiekosten
- **Integratie** - Werkt goed samen
- **Schaalbaar** - Kan groeien met de infrastructuur
- **Populair** - Grote community

## Gevolgen
- Centraal monitoring platform
- Consistente dashboards
- Geïntegreerde alerts

## Alternatieven overwogen
- **ELK stack** - Zwaarder, meer resources
- **Datadog** - Betaald, cloud-based
- **Zabbix** - Meer traditioneel, minder geschikt voor containers