# Backup Role

## Beschrijving
Deze role configureert backups voor databases, volumes, applicaties en systeem configuratie.

## Wat doet deze role?
- Installeert backup tools (rsync, duplicity, restic, borg)
- Maakt backup directories aan
- Configureert database backups (PostgreSQL, MySQL, MongoDB, Redis)
- Configureert Docker volume backups
- Configureert applicatie backups
- Configureert systeem configuratie backups
- Configureert remote backup sync (S3, NFS, rsync, Borg)
- Configureert backup retention policies
- Configureert backup monitoring en alerts

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| backup_databases | false | Database backups inschakelen |
| backup_volumes | false | Volume backups inschakelen |
| backup_applications | false | Applicatie backups inschakelen |
| backup_config | true | Config backups inschakelen |
| backup_remote_enabled | false | Remote backups inschakelen |
| backup_retention_daily | 7 | Dagelijkse backup retention |
| backup_retention_weekly | 4 | Wekelijkse backup retention |
| backup_retention_monthly | 12 | Maandelijkse backup retention |
| backup_retention_yearly | 3 | Jaarlijkse backup retention |

## Tags
- `packages` - Alleen packages installeren
- `directories` - Alleen directories aanmaken
- `database` - Alleen database backups
- `volumes` - Alleen volume backups
- `application` - Alleen applicatie backups
- `config` - Alleen config backups
- `scripts` - Alleen backup scripts
- `cron` - Alleen cron jobs
- `retention` - Alleen retention configuratie
- `remote` - Alleen remote sync configuratie
- `monitoring` - Alleen monitoring configuratie
- `validate` - Alleen validatie
