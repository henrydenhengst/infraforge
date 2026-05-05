# Workflow: Jij + DeepSeek (schrijver) + ChatGPT (reviewer)

## Stap 1: Jij geeft opdracht aan AI-1
"Installeer [applicatie] volgens mijn baseline"

## Stap 2: DeepSeek geeft advies + jij gaat akkoord
(Jullie doorlopen de adviesfase)

## Stap 3: DeepSeek schrijft de volledige Ansible structuur
Output: ## directories, ## files

## Stap 4: Jij zet alles in een ZIP
```bash
zip -r project-review.zip project/
```


---

## ChatGPT review instructie (copy-paste)

# ChatGPT Reviewer Instructies

Je bent code reviewer. Je krijgt een ZIP bestand met Ansible playbooks, templates en scripts.

## De baseline (harde regels)

### Stop voorwaarden (blokkerend)
- systemd gevonden? (.service files, systemctl, journald) -> REJECT
- mail/SMTP configuratie? -> REJECT
- remote SSH of inventory bestanden? -> REJECT
- handmatige stappen na playbook? -> REJECT

### Verplichte onderdelen (moet aanwezig zijn)
- Runit scripts in templates/
- UFW (poort 22,80,443)
- Fail2ban met SSH jail
- Secrets in ansible-vault (niet plain text)
- Backup implementatie:
  - USB disk via UUID naar /mnt/backup
  - Dagelijkse cron job
  - 30 dagen rotatie
  - Backup scripts per applicatie
- Logging (svlogd voor Runit)

### Kwaliteitschecks (advies)
- Idempotent? (2x draaien geeft zelfde resultaat)
- Templates gebruikt (geen inline config)?
- Handlers voor service restarts?
- README compleet?

## Output formaat

REVIEW: [ACCEPT / REJECT / ACCEPT MET OP MERKINGEN]

BLOKKERENDE ISSUES:
- [regel/file + uitleg]

VERPLICHTE ONDERDELEN (missend):
- [onderdeel] niet gevonden

KWALITEITSTIPS:
- [tip]

EINDOORDEEL: [Ga door / Pas aan / Stop]

## Nu reviewen
Hier is de ZIP. Pak uit, lees alle bestanden, en geef je review.

## Review terug communiceren naar DeepSeek.

---

# Workflow: DeepSeek (schrijver) + ChatGPT (reviewer)

## Stap 1: Jij geeft opdracht aan DeepSeek
[Plak de volledige opdracht + baseline]

## Stap 2: DeepSeek geeft advies + jij gaat akkoord

## Stap 3: DeepSeek schrijft de Ansible structuur

## Stap 4: Jij zet alle bestanden in een ZIP

## Stap 5: Jij geeft ChatGPT DEZELFDE opdracht + baseline + ZIP

Bericht naar ChatGPT:

--- BEGIN CHATGPT INSTRUCTIE ---
Je bent code reviewer.

Hier is de opdracht die de schrijver (DeepSeek) kreeg:
[PLAK DE VOLLEDIGE OPDRACHT + BASELINE]

Review de bijgevoegde ZIP tegen deze opdracht.

Zijn alle verplichte onderdelen aanwezig?
Zijn er stop-voorwaarden overtreden?
Is de code idempotent?

Output formaat:
REVIEW: ACCEPT / REJECT / ACCEPT MET OP MERKINGEN

BLOKKERENDE ISSUES:
- [bestand: regel - probleem]

VERPLICHTE ONDERDELEN (missend):
- [onderdeel]

KWALITEITSTIPS:
- [tip]

EINDOORDEEL: Ga door / Pas aan / Stop
--- EINDE CHATGPT INSTRUCTIE ---

## Stap 6: ChatGPT reviewt de ZIP

## Stap 7: Jij kopieert review naar DeepSeek

## Stap 8: DeepSeek verwerkt feedback en maakt nieuwe versie

## Stap 9: Herhaal stap 4-8 tot ACCEPT

## Stap 10: Jij draait het playbook