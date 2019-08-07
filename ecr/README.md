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
