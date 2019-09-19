```sh
kubectl create secret tls your-secret \
  --cert /etc/letsencrypt/live/yourdomain/fullchain.pem --key /etc/letsencrypt/live/yourdomain/privkey.pem
```
