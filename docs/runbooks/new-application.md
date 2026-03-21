# Backup Restore - Runbook

## Stappen

1. **Bekijk backups**
   ls -la /backup/daily/

2. **Herstel configuratie**
   cd /
   tar xzf /backup/daily/etc-YYYYMMDD.tar.gz

3. **Herstel database**
   gunzip < /backup/daily/postgres-YYYYMMDD.sql.gz | psql -U postgres

4. **Herstel Docker volumes**
   docker run --rm -v volume:/data -v $(pwd):/backup alpine tar xzf /backup/volume.tar.gz -C /data