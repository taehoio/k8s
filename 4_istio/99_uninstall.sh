#!/usr/bin/env bash

helm del --purge istio
helm del --purge istio-init
kubectl delete customresourcedefinitions.apiextensions.k8s.io --all
