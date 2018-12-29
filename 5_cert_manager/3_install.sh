#!/usr/bin/env bash

helm install \
    --name cert-manager \
    --namespace istio-system \
    stable/cert-manager
