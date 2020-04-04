## not working yet.

```
helm install --name cf-operator \
     --namespace cfo \
     --set "global.operator.watchNamespace=kubecf" \
     --set features.eirini.enabled=true \
     https://s3.amazonaws.com/cf-operators/helm-charts/cf-operator-v0.4.2-147.gb88e4296.tgz




helm install --name kubecf \
     --namespace kubecf \
     https://kubecf.s3.amazonaws.com/kubecf-v0.0.0-998b961.tgz \
     --set "system_domain=kubecf.example.com" \
     --set "features.eirini.enabled=true" \
     --set "kube.service_cluster_ip_range=10.100.0.0/16" \
     --set "kube.pod_cluster_ip_range=192.168.0.0/16" \
     --set "services.router.type=NodePort" \
     --set "services.ssh-proxy.type=NodePort" \
     --set "services.tcp-router.type=NodePort" \

```
