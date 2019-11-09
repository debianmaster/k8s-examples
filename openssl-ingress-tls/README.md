```sh
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=cape/O=cape"
kubectl create secret tls tls-secret --key tls.key --cert tls.crt
```
