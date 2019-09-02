```sh
k3d create -n tech --publish 443:443 --publish 80:80
sleep 2
export KUBECONFIG="$(k3d get-kubeconfig --name='tech')"
kubectl cluster-info

k apply -f https://raw.githubusercontent.com/heptio/velero/master/examples/minio/00-minio-deployment.yaml
cat .credentials-velero
[default]
aws_access_key_id = 'minio'
aws_secret_access_key = 'minio123'

kubectl config set-context --current --namespace=velero
velero install \
    --provider aws \
    --bucket velero \
    --use-restic \
    --secret-file ./.credentials-velero \
    --use-volume-snapshots=true \
    --backup-location-config region=velero \
    --snapshot-location-config region=velero \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio:9000
    
sleep 10

https://raw.githubusercontent.com/heptio/velero/master/examples/nginx-app/base.yaml

velero backup create b1 --include-namespaces=nginx-example
velero backup describe b1
velero backup logs b1

```
