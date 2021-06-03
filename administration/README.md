
```
kubectl taint nodes $(kubectl get nodes --selector=node-role.kubernetes.io/master | awk 'FNR==2{print $1}') node-role.kubernetes.io/master-

```
