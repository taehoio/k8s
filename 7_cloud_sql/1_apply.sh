#!/usr/bin/env bash

kubectl -n taeho create secret generic cloudsql-instance-credentials \
    --from-file=credentials.json=./taeho-io-220708-cloudsql.json
