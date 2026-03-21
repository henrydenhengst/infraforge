# ADR-0009: Backup strategie

## Status
Geaccepteerd

## Context
We moeten data beschermen tegen verlies door hardware failure, menselijke fouten of security incidenten.

## Beslissing
- **Dagelijkse backups** van configuratie en databases
- **Wekelijkse volledige backups** van alle data
- **Maandelijkse archieven** voor lange termijn
- **Retentie**: 7 dagen dagelijks, 4 weken wekelijks, 12 maanden maandelijks

## Motivering
- **3-2-1 regel** - 3 kopieën, 2 media types, 1 off-site
- **Encryptie** - Alle backups versleuteld
- **Automatisch** - Geen handmatige acties
- **Herstelbaar** - Getest herstel proces

## Gevolgen
- Backup jobs via cron
- MinIO voor object storage
- Remote sync naar off-site locatie

## Alternatieven overwogen
- **Cloud backup** - Vendor lock-in, kosten
- **Geen backups** - Onacceptabel risico