#!/usr/bin/env bash

kubectl -n taeho delete -f taeho_envs.yaml
kubectl -n taeho create -f taeho_envs.yaml
