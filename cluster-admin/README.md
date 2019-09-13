```sh
kubectl create sa hydra -n kube-system
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --serviceaccount=kube-system:hydra
kubectl -n kube-system get secret hydra-token-7jg8n -o jsonpath={.data.token} | base64 -D
```
