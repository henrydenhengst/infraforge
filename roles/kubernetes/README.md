# Kubernetes Role

## Beschrijving
Deze role installeert en configureert een Kubernetes cluster.

## Wat doet deze role?
- Installeert containerd als container runtime
- Installeert kubeadm, kubelet, kubectl
- Initialiseert het cluster op master nodes
- Voegt worker nodes toe aan het cluster
- Installeert CNI plugin (Calico, Flannel, Cilium)
- Configureert kubeconfig
- Installeert addons (Metrics Server, Ingress Controller, Helm)
- Installeert Kubernetes Dashboard
- Valideert cluster status

## Variabelen
| Variabele | Default | Beschrijving |
|-----------|---------|--------------|
| kubernetes_version | 1.29 | Kubernetes versie |
| node_role | worker | Node rol (master/worker) |
| pod_network_cidr | 10.244.0.0/16 | Pod netwerk CIDR |
| service_cidr | 10.96.0.0/12 | Service netwerk CIDR |
| cni_plugin | calico | CNI plugin (calico, flannel, cilium) |
| enable_metrics_server | true | Metrics Server installeren |
| enable_ingress_controller | true | Ingress Controller installeren |
| enable_dashboard | true | Kubernetes Dashboard installeren |
| enable_helm | true | Helm installeren |

## Tags
- `prerequisites` - Alleen prerequisites installeren
- `kernel` - Alleen kernel configuratie
- `containerd` - Alleen containerd installatie
- `packages` - Alleen Kubernetes packages installeren
- `cluster` - Alleen cluster initialisatie
- `kubeconfig` - Alleen kubeconfig configuratie
- `cni` - Alleen CNI installatie
- `addons` - Alleen addons installatie
- `dashboard` - Alleen dashboard installatie
- `validate` - Alleen validatie
