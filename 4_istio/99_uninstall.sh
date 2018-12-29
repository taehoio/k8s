#!/usr/bin/env bash

helm del --purge istio
kubectl delete customresourcedefinitions.apiextensions.k8s.io --all
