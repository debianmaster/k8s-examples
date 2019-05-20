```sh
GET /runners
GET /runners?scope=active
GET /runners?type=project_type
GET /runners?status=active
```

```sh

curl --header "PRIVATE-TOKEN: 9koXpg98eAheJpvBs5tK" "http://gitlab.apps.singa.openshiftworkshop.com/api/v4/runners"

elm install gitlab/gitlab-runner --set gitlabUrl=http://gitlab-unicorn:8181/,runnerRegistrationToken=DummyToken

helm install gitlab/gitlab-runner --set gitlabUrl=http://gitlab.apps.singa.openshiftworkshop.com,runnerRegistrationToken=DummyToken
```
