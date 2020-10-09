```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.40.2/deploy/static/provider/baremetal/deploy.yaml
kubectl -n ingress-nginx  patch deployments ingress-nginx-controller -p '{"spec": {"template": {"spec": {"nodeSelector": {"node-role.kubernetes.io/master": "true"}}}}}'
#. patch ingress-nginx-controller to use hostPort.

```

```
k get deploy -n ingress-nginx ingress-nginx-controller -oyaml
```

```yaml
    spec:
      containers:
      - args:
        - /nginx-ingress-controller
        - --election-id=ingress-controller-leader
        - --ingress-class=nginx
        - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
        - --validating-webhook=:8443
        - --validating-webhook-certificate=/usr/local/certificates/cert
        - --validating-webhook-key=/usr/local/certificates/key
        - --enable-ssl-passthrough=true
 ```
 
 
 ```
 k annotate ing -n cape ui-ingress nginx.ingress.kubernetes.io/ssl-redirect="true"
 k annotate ing -n cape ui-ingress nginx.ingress.kubernetes.io/ssl-passthrough="true"
 ```
