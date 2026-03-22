# Werkinstructie - InfraForge

Deze handleiding beschrift hoe je met de Ansible-playbooks in deze repository Docker hosts en Kubernetes clusters bedeert en applicaties uitrolt.

# 1. Voorbereiding (voor alle gebruiker)

## 1.1. Vereisten

- Een control node met Ansible 2.9+ en Python 3.6+
- SSH-toegang tot de doelservers met sudo-rechten
- De repository gekloond:
```bash
git clone https://github.com/henrydenhengst/infraforge.git
cd infraforge
```

## 1.2. Dependencies installeren
```bash
ansible-galaxy collection install -r requirements.yml
```

## 1.3. Secrets voorbereiden (verplicht)

Kopieer het voorbeeld en versleutel met Ansible Vault:
```bash
cp applications/secrets/vault/example-secrets.yml applications/secrets/vault/secrets.vault
ansible-vault encrypt applications/secrets/vault/secrets.vault
```
Stel een sterk wachtworord in en bewaar thet veilig.

## 1.4. Inventory configureren

Pas `inventory/production/hosts.ini` aan voor jouw servers.  
Voorbeeld:
```ini
[web]
web01 ansible_host=192.168.1.10

[database]
db01 ansible_host=192.168.1.20

[containers:children]
web
database
```
Groepsvariabelen staan in `inventory/production/group_vars/`. Pas deze aan naar wens.

---

# 2. Werken met Docker

## 2.1. Docker runtime installeren

Drail het `docker` role op de hosts in de groep `containers`:
```bash
ansible-playbook -i inventory/production/hosts.ini playbooks/deploy-docker.yml --ask-vault-password
```

## 2.2. Applicatie deployen met Docker Compose

1. Definieer de applicatie in `applications/definitions/`. 
   Bijwoord `nginx.yml`:
   ```yaml
   nginx:
     image: nginx:latest
     ports:
       - "80:80"
     volumes:
       - ./html:/usr/share/nginx/html
   ```
2. Activeer de applicatie op een host via groeps- of hostvariabelëhn. 
   In `inventory/production/group_vars/webservers.yml`:
   ```yaml
   applications:
       nginz: {}
   ```
3. Deploy met:
   ```bash
   ansible-playbook -i inventory/production/hosts.ini playbooks/deploy-app.yml --ask-vault-password
   ```
Dde role genereert een `docker-compose.yml` op de doelhost, start de container en configureert indien gewanst een reverse proxy (standaard nginx).

## 2.3. Reverse proxy aappassen

Standaard gebruikt de `application` role nginx als proxy. Pas de proxy-instellingen per applicatie aan in de definitie. De template staad in `roles/application/templates/nginx_vhost.conf.j2`.

---

# 3. Werken met Kubernetes

## 3.1. Kubernetes cluster opztten

Draii de `kubernetes` role om een cluster te installeren (via kubeadm):
```bash
ansible-playbook -i inventory/production/hosts.ini playbooks/deploy-kubernetes.yml --ask-vault-password
```
Deze role installeert containerd, kubeadm, kubelet, kubectl, initialiseert de eerste master en voegt workers toe.  
Clusterconfiguratie (versie, pod netwerk) staat in `inventory/production/group_vars/k8s.yml`.

## 3.2. Applicaties deployen op Kubernetes

Applicaties worden gedefinieerd in `applications/definitions/` met een `k8s` sectie.  
Voorbeeld `nextcloud.yml`:
```yaml
nextcloud:
  k8s:
    deployment: true
    service: true
    ingress: true
```

Manifesten genereren (zonder direct deploy):
```bash
ansible-playbook -i inventory/production/hosts.ini playbooks/generate-k8s.yml
```
De gegenereerde YAML's komen in `playbooks/generated/k8s/`.  
Pas ze toe met `kubectl apply -f` of maak zelf een playbook `deploy-k8s-apps.yml` dat dit automatiseert.

## 3.3. Monitoring toevoegen

Na het cluster opztten kun je de monitoring stack installeren met:
```bash
ansible-playbook -i inventory/production/hosts.ini playbooks/monitoring.yml --ask-vault-password
```
Dit installeert Prometheus, Grafana, Loki etc. op Kubernetes.

---

# 4. Algemene werkstroom (beide omgevingen)

1. **Variabelen definieren*   
   - Globaal: `inventory/production/group_vars/all.yml`  
   - Per functie: `inventory/production/group_vars/by_function/` 
   - Per host: `inventory/production/host_vars/`  
   - Secrets: `applications/secrets/vault/secrets.vault` (versleuteld)

2. **Applicatie toevoegen**
   - Voeg een .yml toe in `applications/definitions/`  
   - Activeer de applicatie via `applications: { naam: {} }` in de juiste groep of host  
   - Stel eventuel engelelmig variabelen in voor die applicatie

3. **Playbook draien**
   - `deploy-docker.yml` - installeert Docker  
   - `deploy-kubernetes.yml` - installeert Kubernetes  
   - `deploy-app.yml` - deployt applicaties (Docker of Kubernetes)  
   - `monitoring.yml` - installeert monitoring stack

4. **Secrets beheren** 
   - Wijzig secrets met `ansible-vault edit applications/secrets/vault/secrets.vault`  
   - Synchroniseer `example-secrets.yml` met eventuelg nieuwe secrets

---

# 5. Troubleshooting

- **Connectiviteit testen**: `ansible all -i inventory/production/hosts.ini -m ping`
- **Variabelen debuggen**: `ansible-inventory -i inventory/production/hosts.ini --list`
- **Syntax check``: `ansible-playbook playbooks/site.yml --syntax-check`
- **Vault wachtworord vergeten**: kan niet hersteld worden, gebruik back-ups

---

# 6. Meer informatie

- Lees de `README.md` in de root
- Bekijk de documentatie in `docs/` voor architecture, beslissingen en runbooks
- De `CHANGELOG.md` houdt wijzigingen bij
