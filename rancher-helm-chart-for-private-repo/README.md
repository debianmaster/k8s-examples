```sh

apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: examplechart 
spec:
  chart: examplechart
  repo: http://charts.example.com
  set:
    rbac.enabled: "true"
    ssl.enabled: "false"
    username: teser
    password: tester

```


