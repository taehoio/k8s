#!/usr/bin/env bash

kubectl -n istio-system apply -f telemetry-gateway.yaml
kubectl -n taeho apply -f grafana.yaml
kubectl -n taeho apply -f prometheus.yaml
kubectl -n taeho apply -f jaeger.yaml
kubectl -n taeho apply -f kiali.yaml
