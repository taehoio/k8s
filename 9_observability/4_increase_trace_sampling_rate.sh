#!/usr/bin/env bash

# change PILOT_TRACE_SAMPLING env to 100 or something you want.
kubectl -n istio-system apply -f istio-pilot-jaeger_sampling_rate.yaml
kubectl -n istio-system delete pods -l istio=pilot  # to restart istio-pilot

