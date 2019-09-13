# generate generic kuebconfig for GKE
> you need to login with gcloud already.

```sh
wget https://raw.githubusercontent.com/gravitational/teleport/master/examples/gke-auth/get-kubeconfig.sh
chmod +x get-kubeconfig.sh
./get-kubeconfig.sh

cat build/kubeconfig
```
