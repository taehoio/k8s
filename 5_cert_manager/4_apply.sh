#!/usr/bin/env bash

kubectl -n istio-system apply -f egress-rule-letsencrypt-apis.yaml
kubectl -n istio-system apply -f cert-manager-cluster-issuer.yaml
kubectl -n istio-system apply -f cert-manager-certificate.yaml
kubectl -n istio-system delete pods -l istio=ingressgateway  # to restart ingressgateway
kubectl -n taeho apply -f public-gateway.yaml
