# Nginx Role

Installeert en configureert Nginx webserver met HTTPS en monitoring.

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| nginx_worker_processes | auto | Aantal worker processes |
| nginx_worker_connections | 1024 | Max verbindingen per worker |
| nginx_keepalive_timeout | 65 | Keepalive timeout |
| nginx_client_max_body_size | 100M | Maximale upload grootte |
| nginx_server_name | domain | Server name voor default site |
| nginx_ssl_enabled | true | SSL inschakelen |
