
```

echo '
[default]
aws_access_key_id = 'minio'
aws_secret_access_key = 'minio123'
' > ./.credentials-velero

export LAPTOP_IP='192.168.2.1'


k3d create -n c1 --publish 180:80 --publish 1443:443
export KUBECONFIG="$(k3d get-kubeconfig --name='c1')"
kubectl create ns velero 
kubectl apply -f  https://raw.githubusercontent.com/heptio/velero/master/examples/minio/00-minio-deployment.yaml


echo '
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: c1-minio-ingress
  namespace: velero
spec:
  rules:
  - host: minio.'$LAPTOP_IP'.nip.io
    http:
      paths:
      - path: /
        backend:
          serviceName: minio
          servicePort: 9000
' | kubectl apply -f-

velero install \
    --provider aws \
    --bucket velero \
    --use-restic \
    --secret-file ./.credentials-velero \
    --use-volume-snapshots=true \
    --backup-location-config region=velero \
    --snapshot-location-config region=velero \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio.${LAPTOP_IP}.nip.io:180


k3d create -n c2 --publish 280:80 --publish 2443:443
export KUBECONFIG="$(k3d get-kubeconfig --name='c2')"
kubectl create ns velero 
kubectl apply -f  https://raw.githubusercontent.com/heptio/velero/master/examples/minio/00-minio-deployment.yaml


echo '
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: c2-minio-ingress
  namespace: velero
spec:
  rules:
  - host: minio2.'$LAPTOP_IP'.nip.io
    http:
      paths:
      - path: /
        backend:
          serviceName: minio
          servicePort: 9000
' | kubectl apply -f-



velero install \
    --provider aws \
    --bucket velero \
    --use-restic \
    --secret-file ./.credentials-velero \
    --use-volume-snapshots=true \
    --backup-location-config region=velero \
    --snapshot-location-config region=velero \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio2.${LAPTOP_IP}.nip.io:280

```

```
export KUBECONFIG="$(k3d get-kubeconfig --name='c1')"
velero backup get
velero backup-location create ro1-c2 --access-mode=ReadOnly --bucket=velero --provider=aws --config region=minio,s3ForcePathStyle="true",s3Url=http://minio2.${LAPTOP_IP}.nip.io:280
export KUBECONFIG="$(k3d get-kubeconfig --name='c2')"
velero backup create b1
export KUBECONFIG="$(k3d get-kubeconfig --name='c1')"
velero get backups
```



