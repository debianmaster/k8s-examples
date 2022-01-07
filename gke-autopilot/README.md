```
helm repo add jetstack https://charts.jetstack.io
helm repo update
k create ns cert-manager
helm install cert-manager --namespace cert-manager jetstack/cert-manager --set global.leaderElection.namespace=cert-manager --set installCRDs=true --set prometheus.enabled=false
```
