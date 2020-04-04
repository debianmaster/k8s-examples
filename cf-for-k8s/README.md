

```
brew tap k14s/tap
brew install kapp ytt
brew install cloudfoundry/tap/bosh-cli

git clone https://github.com/cloudfoundry/cf-for-k8s
cd cf-for-k8s
./hack/generate-values.sh -d cf.example.com > /tmp/cf-values.yml

# add following to cf-values.yml
app_registry:
  hostname: hub.docker.com
  repository: myuser
  username: myuser
  password: mypass

./bin/install-cf.sh /tmp/cf-values.yml
kubectl get svc -n istio-system istio-ingressgateway  #map this cname or A record to choosen dns wildcard *.cf.example.com 

cf api --skip-ssl-validation https://api.<cf-domain>
cf auth admin <cf_admin_password>  #get this from /tmp/cf-values.yml

cf create-org test-org
cf create-space -o test-org test-space
cf target -o test-org -s test-space


cf enable-feature-flag diego_docker
cf push test-app -o cloudfoundry/diego-docker-app
cf push test-node-app -p tests/smoke/assets/test-node-app
```
