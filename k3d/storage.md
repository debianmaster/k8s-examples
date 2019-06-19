```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: storage-provisioner
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: storage-provisioner
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:persistent-volume-provisioner
subjects:
  - kind: ServiceAccount
    name: storage-provisioner
    namespace: kube-system
---
apiVersion: v1
kind: Pod
metadata:
  name: storage-provisioner
  namespace: kube-system
spec:
  serviceAccountName: storage-provisioner
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  hostNetwork: true
  containers:
  - name: storage-provisioner
    image: gcr.io/k8s-minikube/storage-provisioner:v1.8.1
    command: ["/storage-provisioner"]
    imagePullPolicy: IfNotPresent
    volumeMounts:
    - mountPath: /tmp
      name: tmp
  volumes:
  - name: tmp
    hostPath:
      path: /tmp
      type: Directory
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: standard
  namespace: kube-system
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
provisioner: k8s.io/minikube-hostpath
```
