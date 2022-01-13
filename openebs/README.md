```
gcloud compute instances create openebs1-1 --project=gcp-project-name --zone=us-central1-a --machine-type=e2-standard-2 --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=MIGRATE --service-account=498066266080-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server --create-disk=auto-delete=yes,boot=yes,device-name=openebs1-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220111,mode=rw,size=50,type=projects/gcp-project-name/zones/us-central1-a/diskTypes/pd-balanced --create-disk=auto-delete=yes,device-name=disk-1,mode=rw,name=openebs1-disk-1,size=30,type=projects/gcp-project-name/zones/us-central1-a/diskTypes/pd-balanced --create-disk=auto-delete=yes,device-name=disk-2,mode=rw,name=openebs1-disk-2,size=30,type=projects/gcp-project-name/zones/us-central1-a/diskTypes/pd-balanced --create-disk=auto-delete=yes,device-name=disk-3,mode=rw,name=openebs1-disk-3,size=30,type=projects/gcp-project-name/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

gcloud compute instances ssh openebs1-1

```

```
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.20.14-rc1+k3s2 sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml    
kubectl get nodes
sudo lsblk
sudo apt install open-iscsi -y
sudo systemctl enable --now iscsid
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config   
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm repo add openebs-cstor https://openebs.github.io/cstor-operators
helm repo update
helm upgrade --install openebs-cstor openebs-cstor/cstor -n openebs --set openebsNDM.enabled=true --create-namespace
kubectl get bd -n openebs
```


```
kubectl get bd -n openebs
NAME                                           NODENAME     SIZE          CLAIMSTATE   STATUS   AGE
blockdevice-32202e229cd0cd793778b98038e52ddd   openebs1-1   32211189248   Unclaimed    Active   29s
blockdevice-f2ab2e8cf3fb083fed2d00f3ac895739   openebs1-1   32211189248   Unclaimed    Active   28s
blockdevice-b8c8dbbfa0140cf63d734b8ec57faea1   openebs1-1   32211189248   Unclaimed    Active   28s

```
```
cat << EOF | kubectl apply -f -
apiVersion: cstor.openebs.io/v1
kind: CStorPoolCluster
metadata:
  name: cstor-storage
  namespace: openebs
spec:
  pools:
    - nodeSelector:
        kubernetes.io/hostname: "openebs1-1"
      dataRaidGroups:
        - blockDevices:
            - blockDeviceName: "blockdevice-32202e229cd0cd793778b98038e52ddd" 
            - blockDeviceName: "blockdevice-f2ab2e8cf3fb083fed2d00f3ac895739"
            - blockDeviceName: "blockdevice-b8c8dbbfa0140cf63d734b8ec57faea1"
      poolConfig:
        dataRaidGroupType: "stripe"
EOF
```
```
cat << EOF | kubectl apply -f -
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: cstor-csi
provisioner: cstor.csi.openebs.io
allowVolumeExpansion: true
parameters:
  cas-type: cstor
  # cstorPoolCluster should have the name of the CSPC
  cstorPoolCluster: cstor-storage
  # replicaCount should be <= no. of CSPI
  replicaCount: "1"
EOF
```

```
cat << EOF | kubectl apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: demo-cstor-vol
spec:
  storageClassName: cstor-csi
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Mi
EOF
```

```
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: busybox
  name: busybox
spec:
  replicas: 1
  selector:
    matchLabels:
      app: busybox
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: busybox
    spec:
      containers:
      - command:
          - sh
          - -c
          - 'date >> /mnt/openebs-csi/date.txt; hostname >> /mnt/openebs-csi/hostname.txt; sync; sleep 5; sync; tail -f /dev/null;'
        image: busybox
        env:
        - name: DEMO_GREETING
          value: "Hello from the environment"
        - name: DEMO_FAREWELL
          value: "Such a sweet sorrow"
        - name: DEMO_FAREWELL2
          value: "Such a sweet sorrow2"          
        imagePullPolicy: Always
        name: busybox
        volumeMounts:
        - mountPath: /mnt/openebs-csi
          name: demo-vol
      volumes:
      - name: demo-vol
        persistentVolumeClaim:
          claimName: demo-cstor-vol        
EOF
```

```
kubectl exec -it deploy/busybox -- cat /mnt/openebs-csi/date.txt

kubectl exec -it deploy/busybox -- printenv | grep DEMO

```
