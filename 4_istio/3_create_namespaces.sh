#!/usr/bin/env bash

kubectl create namespace taeho
kubectl label namespace taeho istio-injection=enabled
