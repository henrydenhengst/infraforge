# ADR-0007: Secrets management

## Status
Geaccepteerd

## Context
We moeten wachtwoorden, API keys en andere gevoelige data veilig opslaan.

## Beslissing
We gebruiken **Ansible Vault** voor configuratie secrets.

## Motivering
- **Geïntegreerd** - Geen extra tool nodig
- **Versiebeheer** - Versleutelde bestanden kunnen in Git
- **Eenvoudig** - Eén commando voor encryptie
- **Role compatibel** - Werkt met Ansible variabelen

## Gevolgen
- Secrets worden versleuteld opgeslagen
- Vault wachtwoord moet veilig worden bewaard
- Secrets per omgeving (prod, staging, test)

## Alternatieven overwogen
- **HashiCorp Vault** - Krachtig maar complex voor deze fase
- **AWS Secrets Manager** - Vendor lock-in
- **Environment variables** - Onveilig, niet in versiebeheer