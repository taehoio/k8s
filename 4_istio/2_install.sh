#!/usr/bin/env bash

helm install istio-1.0.5/install/kubernetes/helm/istio \
    --name istio \
    --namespace istio-system \
    --set tracing.enabled=true \
    --set global.mtls.enabled=true \
    --set grafana.enabled=true \
    --set grafana.persist=true  \
    --set grafana.accessMode=ReadWriteOnce \
    --set grafana.security.enabled=true \
    --set telemetry-gateway.grafanaEnabled=true \
    --set telemetry-gateway.prometheusEnabled=true \
    --set kiali.enabled=true \
    --set servicegraph.enabled=true
