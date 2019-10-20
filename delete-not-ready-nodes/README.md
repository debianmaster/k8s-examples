```
kubectl delete no $(kubectl get nodes | grep NotReady | awk '{print $1}')
```
