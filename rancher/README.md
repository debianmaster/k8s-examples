
```sh
export certdir=/home/ubuntu/cloud.run9.io

 sudo docker run -v /opt/rancher:/var/lib/rancher -d \
  -v ${certdir}/fullchain1.pem:/etc/rancher/ssl/cert.pem \
  -v ${certdir}/privkey1.pem:/etc/rancher/ssl/key.pem \
  -v ${certdir}/cert1.pem:/etc/rancher/ssl/cacerts.pem \
  --restart=unless-stopped \
  -p 980:80 -p 9443:443 \
  rancher/rancher:latest
```
