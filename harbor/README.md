> cert.yaml
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: reg-crt
spec:
  secretName: reg-crt-secret
  dnsNames:
  - reg.dev.sh
  - notary.dev.sh
  acme:
    config:
    - http01:
        ingressClass: traefik
      domains:
      - reg.dev.sh
      - notary.dev.sh
  issuerRef:
    name: letsencrypt-prod
    # We can reference ClusterIssuers by changing the kind here.
    # The default value is Issuer (i.e. a locally namespaced Issuer)
    kind: Issuer
```
> issuer.yaml
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: cert-manager
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: 9chakri@gmail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-prod
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
          class: traefik
```


```sh
helm install --name harbor harbor/harbor --set expose.ingress.hosts.core=reg.dev.sh --set expose.ingress.hosts.notary=notary.dev.sh --set externalURL=https://reg.dev.sh --set expose.tls.secretName=reg-crt-secret

```
