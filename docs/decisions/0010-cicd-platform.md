# ADR-0003: VLAN segmentatie

## Status
Geaccepteerd

## Context
We moeten netwerk segmentatie implementeren voor security en isolatie van services.

## Beslissing
We gebruiken de volgende VLAN indeling:

| VLAN | Naam | Subnet | Doel |
|------|------|--------|------|
| 10 | Management | 10.10.10.0/24 | Beheer toegang |
| 20 | DMZ | 10.10.20.0/24 | Publieke services |
| 30 | Applicatie | 10.10.30.0/24 | Backend services |
| 40 | Database | 10.10.40.0/24 | Gevoelige data |
| 50 | Storage | 10.10.50.0/24 | Opslag |
| 99 | Staging | 10.10.99.0/24 | Test omgeving |

## Motivering
- **Security** - Isolatie tussen verschillende service types
- **Firewall policies** - Eenvoudig te definiëren per VLAN
- **Schaalbaar** - Ruimte voor groei binnen elk subnet
- **Standaard** - VLAN 10,20,30,40,50 zijn veelgebruikte conventies

## Gevolgen
- Strikt gescheiden netwerkverkeer
- Firewall rules per VLAN
- Betere monitoring per zone

## Alternatieven overwogen
- **Flat network** - Geen isolatie, security risico
- **Micro-segmentatie** - Te complex voor deze fase