```sh
aws ecr get-login --region ap-southeast-1 --no-include-email
```


```sh
kubectl create secret docker-registry aws-registry \
              --docker-server=https://dummy.dkr.ecr.ap-southeast-1.amazonaws.com \
--docker-username=AWS \
--docker-password=$(aws ecr get-login --region ap-southeast-1 --no-include-email) \
--docker-email=no@email.local
```

```
AWS_ACCOUNT=<XXXXXXXXXXX-AWS-ACCOUNT-ID>
AWS_REGION=ap-southeast-2
DOCKER_REGISTRY_SERVER=https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
DOCKER_USER=AWS
DOCKER_PASSWORD=`aws ecr get-login --region ${AWS_REGION} --registry-ids ${AWS_ACCOUNT} | cut -d' ' -f6`

kubectl delete secret aws-registry || true

kubectl create secret docker-registry aws-registry \
--docker-server=$DOCKER_REGISTRY_SERVER \
--docker-username=$DOCKER_USER \
--docker-password=$DOCKER_PASSWORD \
--docker-email=no@email.local

              
kubectl patch serviceaccount default -p '{"imagePullSecrets":[{"name":"aws-registry"}]}'              
```
