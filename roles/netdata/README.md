# Netdata Role

## Beschrijving
Netdata performance monitoring voor real-time systeem metrics.

## Wat doet deze role?
- Start Netdata container
- Configureert poorten en volumes
- Integreert met Traefik voor HTTPS
- Valideert dat de service draait

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| netdata_port | 19999 | Netdata web interface poort |
