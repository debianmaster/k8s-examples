## update configs
> . update your ngrok auth key and master node label in deploy.yaml

## deploy following pod on any master
```sh
k apply -f deploy.yaml
```


### get kngrok url
```
kubectl exec $(kubectl get pods -l=app=ngrok -o=jsonpath='{.items[0].metadata.name}') -- curl http://localhost:4040/api/tunnels
```

if you have jq

```sh
kubectl exec $(kubectl get pods -l=app=ngrok -o=jsonpath='{.items[0].metadata.name}') -- curl http://localhost:4040/api/tunnels | jq .
```
