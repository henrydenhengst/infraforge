# Redis Role

Installeert en configureert Redis in-memory database met monitoring.

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| redis_port | 6379 | Redis poort |
| redis_password | vault_redis_password | Redis wachtwoord |
| redis_maxmemory | 2gb | Maximaal geheugen |
| redis_maxmemory_policy | allkeys-lru | Evictie policy |
| redis_appendonly | yes | AOF persistentie |
