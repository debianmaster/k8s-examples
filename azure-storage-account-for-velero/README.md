
```
AZURE_BACKUP_RESOURCE_GROUP=Velero_Stg_Backups

az group create -n $AZURE_BACKUP_RESOURCE_GROUP --location WestUS

AZURE_STORAGE_ACCOUNT_ID="velero$(uuidgen | cut -d '-' -f5 | tr '[A-Z]' '[a-z]')" 

AZURE_STORAGE_ACCOUNT_ID=veleroeeasdfasdfsda63b2b5ef6

az storage account create     --name $AZURE_STORAGE_ACCOUNT_ID     --resource-group $AZURE_BACKUP_RESOURCE_GROUP     --sku Standard_GRS     --encryption-services blob     --https-only true     --kind BlobStorage     --access-tier Hot
BLOB_CONTAINER=velero-stg

az storage container create -n $BLOB_CONTAINER --public-access off --account-name $AZURE_STORAGE_ACCOUNT_ID

AZURE_SUBSCRIPTION_ID=`az account list --query '[?isDefault].id' -o tsv`
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "velero" --role "Contributor" --query 'password' -o tsv`
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "velero-stg" --role "Contributor" --query 'password' -o tsv`
AZURE_CLIENT_ID=`az ad sp list --display-name "velero" --query '[0].appId' -o tsv`


cat << EOF  > ./credentials-velero
AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
AZURE_TENANT_ID=${AZURE_TENANT_ID}
AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
EOF

cat ./credentials-velero
```
