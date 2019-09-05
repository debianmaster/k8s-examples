```sh
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/auth-delegator.yaml
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/auth-reader.yaml
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/metrics-apiservice.yaml
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/metrics-server-deployment.yaml
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/metrics-server-service.yaml
k apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/metrics-server/resource-reader.yaml
  ```
