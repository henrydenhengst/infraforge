# PostgreSQL Role

## Beschrijving
Deze role installeert en configureert PostgreSQL database.

## Wat doet deze role?
- Installeert PostgreSQL server en client
- Configureert postgresql.conf en pg_hba.conf
- Maakt databases aan
- Maakt database gebruikers aan
- Verleent privileges
- Installeert extensions
- Configureert backups
- Configureert monitoring met PostgreSQL Exporter

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| postgresql_version | 15 | PostgreSQL versie |
| postgresql_port | 5432 | PostgreSQL poort |
| postgresql_max_connections | 200 | Max verbindingen |
| postgresql_shared_buffers | 128MB | Shared buffers |
| postgresql_databases | [] | Databases om aan te maken |
| postgresql_users | [] | Gebruikers om aan te maken |
| postgresql_privileges | [] | Privileges om te verlenen |
| postgresql_extensions | [] | Extensions om te installeren |
| postgresql_backup_enabled | true | Backups inschakelen |
| postgresql_monitoring_enabled | true | Monitoring inschakelen |

## Tags
- `install` - Alleen PostgreSQL installeren
- `service` - Alleen service configuratie
- `config` - Alleen configuratie
- `databases` - Alleen databases aanmaken
- `users` - Alleen gebruikers aanmaken
- `privileges` - Alleen privileges verlenen
- `extensions` - Alleen extensions installeren
- `backup` - Alleen backup configuratie
- `monitoring` - Alleen monitoring configuratie
- `validate` - Alleen validatie
