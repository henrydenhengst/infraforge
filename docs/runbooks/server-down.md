# Server Down - Runbook

## Detectie
- Server niet bereikbaar
- Monitoring alert

## Impact
- Services niet beschikbaar
- Gebruikers kunnen niet inloggen

## Prioriteit: P1 - Kritiek

## Stappen

### 1. Controleer status
- Ping test
- SSH test
- IPMI status

### 2. Herstart server
- Via IPMI
- Via console (indien nodig)

### 3. Herstel services
- Draai playbooks
- Controleer Docker
- Controleer databases

### 4. Valideer herstel
- Health endpoints checken
- Monitoring checken

## Escalatie
- Ops team: 15 min
- Platform team: 30 min
- Management: 1 uur