cat << EOF  | kubectl -n istio-system apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: istio-prometheus-pvc
  namespace: istio-system
  labels:
    app: prometheus
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
EOF
