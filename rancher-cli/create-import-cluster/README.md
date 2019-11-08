```sh
rancher cluster create my-imported-cluster --import
# kubectl command
rancher cluster import my-imported-cluster -q | head -1
# kubectl insecure command (self signed certificates on Rancher)
rancher cluster import my-imported-cluster -q | tail -1
# wait til cluster is ready
rancher wait my-imported-cluster
```

credits: https://forums.rancher.com/t/programmatically-import-cluster-no-web-ui/11776/9
