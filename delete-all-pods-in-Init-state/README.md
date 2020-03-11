```sh
k get po | grep Init | awk '{ print $1}' | xargs kubectl delete po --force --grace-period=0
```
