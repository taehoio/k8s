# delete promethus deployment first if necessary
# don't forget to set `securityContext: fsGroup: 65534`

cat << EOF | kubectl -n istio-system apply -f -
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    app: prometheus
    chart: prometheus-1.0.5
    heritage: Tiller
    release: istio
  name: prometheus
  namespace: istio-system
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: prometheus
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    metadata:
      annotations:
        scheduler.alpha.kubernetes.io/critical-pod: ""
        sidecar.istio.io/inject: "false"
      creationTimestamp: null
      labels:
        app: prometheus
    spec:
      affinity:
        nodeAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - amd64
            weight: 2
          - preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - ppc64le
            weight: 2
          - preference:
              matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - s390x
            weight: 2
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: beta.kubernetes.io/arch
                operator: In
                values:
                - amd64
                - ppc64le
                - s390x
      containers:
      - args:
        - --storage.tsdb.retention=30d
        - --config.file=/etc/prometheus/prometheus.yml
        image: docker.io/prom/prometheus:v2.3.1
        imagePullPolicy: IfNotPresent
        livenessProbe:
          failureThreshold: 3
          httpGet:
            path: /-/healthy
            port: 9090
            scheme: HTTP
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        name: prometheus
        ports:
        - containerPort: 9090
          name: http
          protocol: TCP
        readinessProbe:
          failureThreshold: 3
          httpGet:
            path: /-/ready
            port: 9090
            scheme: HTTP
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            cpu: 10m
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /etc/prometheus
          name: config-volume
        - mountPath: /etc/istio-certs
          name: istio-certs
        - mountPath: /prometheus/data
          name: prometheus-data
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext:
        fsGroup: 65534
      serviceAccount: prometheus
      serviceAccountName: prometheus
      terminationGracePeriodSeconds: 30
      volumes:
      - configMap:
          defaultMode: 420
          name: prometheus
        name: config-volume
      - name: istio-certs
        secret:
          defaultMode: 420
          optional: true
          secretName: istio.default
      - name: prometheus-data
        persistentVolumeClaim:
          claimName: istio-prometheus-pvc
status:
  conditions:
  - lastTransitionTime: 2019-01-03T10:00:44Z
    lastUpdateTime: 2019-01-03T10:00:44Z
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: 2019-01-05T23:10:52Z
    lastUpdateTime: 2019-01-05T23:10:52Z
    message: ReplicaSet "prometheus-5fcfc57484" has timed out progressing.
    reason: ProgressDeadlineExceeded
    status: "False"
    type: Progressing
  observedGeneration: 7
  replicas: 1
  unavailableReplicas: 1
  updatedReplicas: 1
EOF
