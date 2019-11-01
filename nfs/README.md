## Simple
```
 k apply -f https://raw.githubusercontent.com/debianmaster/k8s-examples/master/nfs/nfs.yaml
 k patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.beta.kubernetes.io/is-default-class":"false"}}}'
```

## Create 

```sh
   k apply -f https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/nfs/deploy/kubernetes/deployment.yaml
   k apply -f https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/nfs/deploy/kubernetes/class.yaml
   k patch storageclass example-nfs -p '{"metadata":{"annotations":{"storageclass.beta.kubernetes.io/is-default-class":"true"}}}'
   k get sc
   oc adm policy add-cluster-role-to-user cluster-admin -z nfs-provisioner --dry-run -oyaml | kubectl apply -f-
 ```


 ## Delete

```sh
   k delete -f https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/nfs/deploy/kubernetes/deployment.yaml
   k delete -f https://raw.githubusercontent.com/kubernetes-incubator/external-storage/master/nfs/deploy/kubernetes/class.yaml
 ```
