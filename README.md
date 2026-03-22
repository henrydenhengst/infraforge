# Ansible Infrastructuur

Dit is de Infrastructure-as-Code repository voor onze complete omgeving.

| Categorie | Badges |
| :--- | :--- |
| **Kern** | ![Ansible](https://img.shields.io/badge/Ansible-2.10+-black?style=flat-square&logo=ansible) ![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat-square&logo=python&logoColor=white) ![YAML](https://img.shields.io/badge/YAML-Configuration-red?style=flat-square&logo=yaml&logoColor=white) |
| **Container & Orchestratie** | ![Docker](https://img.shields.io/badge/Docker-CE-2496ED?style=flat-square&logo=docker&logoColor=white) ![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28+-326CE5?style=flat-square&logo=kubernetes&logoColor=white) ![Helm](https://img.shields.io/badge/Helm-3.0+-0F1689?style=flat-square&logo=helm&logoColor=white) |
| **Ondersteunde OS** | ![Debian](https://img.shields.io/badge/Debian-12+-A81D33?style=flat-square&logo=debian&logoColor=white) ![RedHat](https://img.shields.io/badge/RHEL-9+-EE0000?style=flat-square&logo=redhat&logoColor=white) ![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04+-E95420?style=flat-square&logo=ubuntu&logoColor=white) ![Alpine](https://img.shields.io/badge/Alpine-3.19+-0D597F?style=flat-square&logo=alpinelinux&logoColor=white) ![SUSE](https://img.shields.io/badge/SUSE-15+-32CD32?style=flat-square&logo=suse&logoColor=white) ![Arch](https://img.shields.io/badge/Arch_Linux-Rolling-1793D1?style=flat-square&logo=archlinux&logoColor=white) |
| **Observability & Backup** | ![Prometheus](https://img.shields.io/badge/Prometheus-2.0+-E6522C?style=flat-square&logo=prometheus&logoColor=white) ![Grafana](https://img.shields.io/badge/Grafana-9.0+-F46800?style=flat-square&logo=grafana&logoColor=white) ![Loki](https://img.shields.io/badge/Loki-2.8+-blue?style=flat-square&logo=grafana) ![Tempo](https://img.shields.io/badge/Tempo-2.0+-yellow?style=flat-square&logo=grafana) ![Rclone](https://img.shields.io/badge/Backup-Rclone-2C8EBB?style=flat-square&logo=rclone&logoColor=white) ![Rsync](https://img.shields.io/badge/Backup-Rsync-32CD32?style=flat-square&logo=linux&logoColor=white) |
| **DevOps Tools** | ![Terraform](https://img.shields.io/badge/Terraform-1.5+-7B42BC?style=flat-square&logo=terraform) ![OpenTofu](https://img.shields.io/badge/OpenTofu-1.6+-blue?style=flat-square) ![Packer](https://img.shields.io/badge/Packer-1.9+-02A8EF?style=flat-square&logo=packer) ![ArgoCD](https://img.shields.io/badge/ArgoCD-2.7+-EF7B2D?style=flat-square&logo=argo) ![GitLab](https://img.shields.io/badge/GitLab-16.0+-FC6D26?style=flat-square&logo=gitlab) ![Jenkins](https://img.shields.io/badge/Jenkins-2.4+-D24939?style=flat-square&logo=jenkins) ![Trivy](https://img.shields.io/badge/Trivy-0.45+-38A3A5?style=flat-square&logo=trivy) ![Vault](https://img.shields.io/badge/HashiCorp_Vault-1.14+-black?style=flat-square&logo=vault) |
| **Security** | ![Ansible Vault](https://img.shields.io/badge/Secrets-Encrypted-yellow?style=flat-square&logo=ansible) ![CIS Benchmarks](https://img.shields.io/badge/CIS_Benchmarks-Partial-blue?style=flat-square) ![License](https://img.shields.io/badge/License-MIT-green?style=flat-square) |
| **DevOps Ready** | ![IaC](https://img.shields.io/badge/Infrastructure_as_Code-Ansible-blue?style=flat-square) ![GitOps](https://img.shields.io/badge/GitOps-Ready-blue?style=flat-square) ![CI/CD](https://img.shields.io/badge/CI/CD-Pending-orange?style=flat-square) |
| **Status** | ![Version](https://img.shields.io/badge/Version-0.0.1-orange?style=flat-square) ![Docs](https://img.shields.io/badge/Docs-Incomplete-yellow?style=flat-square) ![Molecule](https://img.shields.io/badge/Testing-Molecule-blue?style=flat-square) |

## QuickStart  

[Start hier met runbooks](docs/runbooks/start.md)
  
  
[Documentatie startpunt](docs/README.md)


```bash
# Installeer dependencies
ansible-galaxy collection install -r requirements.yml

# Test connectiviteit
ansible all -m ping -i inventory/production/hosts.ini
```
