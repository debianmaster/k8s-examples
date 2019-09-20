```
https://stackoverflow.com/questions/51873072/cant-push-image-to-google-container-registry-caller-does-not-have-permission
export PROJECT=pacific-shelter-218
export KEY_NAME=key-name1
export KEY_DISPLAY_NAME='My Key Name'

sudo gcloud iam service-accounts create ${KEY_NAME} --display-name ${KEY_DISPLAY_NAME}
sudo gcloud iam service-accounts list
sudo gcloud iam service-accounts keys create --iam-account ${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com key.json
sudo gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/storage.admin
sudo docker login -u _json_key -p "$(cat key.json)" https://gcr.io
sudo docker push  gcr.io/pacific-shelter-218/mypcontainer:v2
```
