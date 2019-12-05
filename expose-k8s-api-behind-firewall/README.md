```sh
k3d create -n test -a 6443
npm install -g localtunnel
lt  --local-https --allow-invalid-cert --port 6443
```
