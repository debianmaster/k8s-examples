> you need to have `oc` (openshift3/4) .  cli
```sh
k create sa customsa -n kube-system
oc -n kube-system sa create-kubeconfig customsa  > ~/.kube/customsa.yaml
oc adm policy add-cluster-role-to-user cluster-admin -z customsa -n kube-system
```
