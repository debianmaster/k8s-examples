```sh
kubectl create secret tls your-secret \
  --cert /etc/letsencrypt/live/yourdomain/fullchain.pem --key /etc/letsencrypt/live/yourdomain/privkey.pem
```


https://medium.com/@Amet13/wildcard-k8s-4998173b16c8
