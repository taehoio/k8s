#!/usr/bin/env bash

kubectl create secret generic cert-manager-credentials \
    --from-file=./gcp-dns-admin.json \
    --namespace=istio-system
