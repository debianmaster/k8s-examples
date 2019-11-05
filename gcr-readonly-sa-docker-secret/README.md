```sh
gcloud iam service-accounts create test-read-only --description "test readyonly SA for pulling docker images"
gcloud iam service-accounts list
gsutil acl ch -u test-readonly@the-project.iam.gserviceaccount.com:R gs://artifacts.the-project.appspot.com
gcloud projects add-iam-policy-binding the-project --member serviceAccount:test-readonly@tthe-project.iam.gserviceaccount.com --role roles/storage.objectViewer


gcloud iam service-accounts keys create \
      --iam-account test-readonly@the-project.iam.gserviceaccount.com key.json
```
