# Disk Full - Runbook

## Detectie
- Disk usage > 85% alert

## Stappen

1. **Bekijk gebruik**
   df -h
   du -sh /* | sort -h

2. **Cleanup Docker**
   docker system prune -a -f

3. **Cleanup logs**
   journalctl --vacuum-size=500M
   find /var/log -name "*.log" -mtime +30 -delete

4. **Controleer**
   df -h