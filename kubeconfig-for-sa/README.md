```
touch ~/.kube/myproj-gke.yaml
export KUBECONFIG=~/.kube/myproj-gke.yaml
gcloud container clusters get-credentials myproj-gke-cluster --region us-central1 --project myproject-k8s
kubectl get nodes
oc create sa myproj-devops -n kube-system
oc create sa myproj-devops -n default
oc adm policy add-cluster-role-to-user cluster-admin -z myproj-devops -n default 
oc sa
oc sa create-kubeconfig -h
oc sa create-kubeconfig myproj-devops > myproj-devops.kubeconfig
cat myproj-devops.kubeconfig 
unset KUBECONFIG
kubectl get nodes
export KUBECONFIG=./myproj-devops.kubeconfig 
kubectl get nodes

 ```
