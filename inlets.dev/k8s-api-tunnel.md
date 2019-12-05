## On exit node

```shell
export token=$(head -c 16 /dev/urandom | shasum | cut -d" " -f1)
inlets server --port=8090 --token="$token" --print-token=true
```



## On k8s cluster
```sh
kubectl create secret generic inlets-token --from-literal token=${TOKEN}
```
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: inlets
spec:
  replicas: 1
  selector:
    matchLabels:
      app: inlets
  template:
    metadata:
      labels:
        app: inlets
    spec:
      containers:
      - name: inlets
        image: alexellis2/inlets:2.1.0
        imagePullPolicy: Always
        command: ["inlets"]
        args:
        - "client"
        - "--remote=ws://192.168.65.2:8090"
        - "--upstream=cluster1.run=https://kubernetes.default:443"
        - "--token-from=/var/inlets/token"
        volumeMounts:
          - name: inlets-token-volume
            mountPath: /var/inlets/
      volumes:
        - name: inlets-token-volume
          secret:
            secretName: inlets-token
```
