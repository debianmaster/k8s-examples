```sh
kubectl create sa hydra -n kube-system
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --serviceaccount=kube-system:hydra
k get secret default-token-vr4g8 -o jsonpath={.data.token} | base64 -D
```
