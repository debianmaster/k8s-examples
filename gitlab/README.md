

```sh
k3d create --api-port 6550 --publish 80:80 --publish 443:443 --workers 1
export KUBECONFIG="$(k3d get-kubeconfig --name='k3s-default')"
kubectl cluster-info
sleep 3
helm init
oc adm policy add-cluster-role-to-user cluster-admin -z default -n kube-system

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600 \
  --set global.hosts.domain=192.168.1.70.nip.io \
  --set global.hosts.externalIP=192.168.1.70 \
  --set certmanager-issuer.email=me@example.com \
  --set prometheus.install=false 

http://gitlab.192.168.1.70.nip.io/
k delete ds svclb-traefik -n kube-system
k delete ds svclb-traefik -n kube-system

kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

```
