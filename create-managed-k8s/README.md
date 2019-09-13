#AKS
```
az ad sp create-for-rbac --skip-assignment --resource-group Bydra

{
  "appId": "lkjlk-9898-4b1d-b328-laksjlkj",
  "displayName": "azure-cli-2019-09-13-07-03-38",
  "name": "http://azure-cli-2099-09-13-07-03-38",
  "password": "kjhkjh-f8c9-48df-a661-lkjlkjlk",
  "tenant": "asdfasdf-f0f3-4588-8ba3-;lk;k;"
}

az aks create \
    --resource-group Bydra \
    --name bydra \
    --node-count 1 \
    --generate-ssh-keys

az aks get-credentials --resource-group Bydra --name bydra

--service-principal <appId> \
    --client-secret <password>
```
