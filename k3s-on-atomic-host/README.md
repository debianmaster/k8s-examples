```sh
setenforce 0
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 INSTALL_K3S_SELINUX_WARN=true  sh -
```
