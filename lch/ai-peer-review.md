# Workflow: DeepSeek (schrijver) + ChatGPT (reviewer)

Stap 1: Jij geeft opdracht aan DeepSeek (plak opdracht + baseline)

Stap 2: DeepSeek geeft advies, jij gaat akkoord

Stap 3: DeepSeek schrijft Ansible code

Stap 4: Jij zet code in een ZIP: zip -r project-review.zip project/

Stap 5: Jij stuurt naar ChatGPT:

"Je bent reviewer. Dit is de opdracht die DeepSeek kreeg: [PLAK HIER OPDRACHT + BASELINE] Review de ZIP tegen deze opdracht.

Output format:
REVIEW: ACCEPT / REJECT / ACCEPT MET OP MERKINGEN
BLOKKERENDE ISSUES: (bestand: regel - probleem)
VERPLICHTE ONDERDELEN (missend): (onderdeel)
KWALITEITSTIPS: (tip)
EINDOORDEEL: Ga door / Pas aan / Stop"

Stap 6: ChatGPT reviewt de ZIP

Stap 7: Jij kopieert review naar DeepSeek

Stap 8: DeepSeek verwerkt feedback

Stap 9: Herhaal stap 4-8 tot ACCEPT

Stap 10: Jij draait het playbook