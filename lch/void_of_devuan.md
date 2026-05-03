# OS Keuze Advies: Void vs Devuan

## Vergelijking

| Aspect | Void Linux | Devuan |
|--------|------------|--------|
| Init systeem | Runit (eigen, licht) | OpenRC (stabiel, bekend) |
| Package manager | Xbps (eigen, snel) | APT (Debian, vertrouwd) |
| Grootte | Minimalistisch | Licht maar completer |
| Documentatie | Minder, maar goed | Veel (Debian basis) |
| Community | Kleiner, dedicated | Groter, stabiel |
| Updates | Rolling release | Stable releases |

## Kies Void Linux als:

- Je een minimale, snelle server wilt
- Je Runit wilt leren (simpeler dan systemd)
- Rolling release model ok is
- Je weinig overhead wilt (RAM/CPU)
- De applicaties in de Void repos zitten

## Kies Devuan als:

- Je Debian/APT gewend bent
- Je liever stable releases hebt
- Je grotere community support wilt
- Je zeker wilt zijn van package beschikbaarheid
- Je OpenRC prefereert boven Runit

## Advies voor Jouw Methodiek

Jouw voorkeuren:
- Idempotent config management
- Localhost only
- Volledige stack (Grav + Mattermost + PostgreSQL)

**Aanbevolen: Devuan**

Redenen:
1. Package beschikbaarheid (Mattermost in repos)
2. APT is vertrouwder, minder verrassingen
3. Meer voorbeeld playbooks beschikbaar
4. Stable release beter voor server

## Alternatief: Void

Als je bereid bent meer zelf te doen:
- Void is prachtig en schoon
- Runit is heerlijk simpel
- Meer leerervaring

## Conclusie

| Scenario | Keuze |
|----------|-------|
| Leren en maximale controle | Void Linux |
| Productie zonder verrassingen | Devuan |
| Minimaal resource gebruik | Void Linux |
| Maximale package support | Devuan |