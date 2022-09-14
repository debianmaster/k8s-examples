

## TLS passthrough install

```
helm repo add nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx/ingress-nginx nginx-ingress -f values.yaml

```
## values.yaml 

```
fullnameOverride: ingress-nginx
controller:       	
  kind: DaemonSet
  hostNetwork: true
  hostPort:
    enabled: true
  service:
    enabled: false
  publishService:
    enabled: true
  metrics:
    enabled: true
    serviceMonitor:
      enabled: false
  config:
    use-forwarded-headers: "true"
  extraArgs:
    enable-ssl-passthrough: "true"
  admissionWebhooks:
    enabled: false
  setAsDefaultIngress: "true" 
```  
