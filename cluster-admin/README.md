```sh
kubectl create sa hydra -n kube-system
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --serviceaccount=kube-system:hydra
```
