# ADR-0004: Ondersteuning voor 5 Linux families

## Status
Geaccepteerd

## Context
We moeten verschillende Linux distributies ondersteunen voor flexibiliteit en toekomstbestendigheid.

## Beslissing
We ondersteunen 5 Linux families:

| Familie | Distributies | Package Manager | Init System |
|---------|--------------|-----------------|-------------|
| Debian | Debian, Ubuntu | apt | systemd |
| RedHat | RHEL, CentOS, Rocky, Alma, Fedora | dnf/yum | systemd |
| SUSE | openSUSE, SLES | zypper | systemd |
| Arch | Arch Linux | pacman | systemd |
| Alpine | Alpine Linux | apk | openrc |

## Motivering
- **Flexibiliteit** - Keuzevrijheid voor teams
- **Toekomstbestendig** - Onafhankelijk van één leverancier
- **Container optimalisatie** - Alpine is ideaal voor containers
- **Leercurve** - Dezelfde Ansible code werkt overal

## Gevolgen
- Meer testwerk (5 varianten)
- OS-specifieke variabelen in roles
- Molecule tests voor elke familie

## Alternatieven overwogen
- **Alleen Debian** - Te beperkend, geen keuzevrijheid
- **Alleen RedHat** - Minder geschikt voor containers