#!/usr/bin/env bash

GCP_PROJECT=taeho-io-220708
MEMBER_NAME=terraform-admin

gcloud iam service-accounts create ${MEMBER_NAME} \
    --display-name=${MEMBER_NAME} \
    --project=${GCP_PROJECT} && \
\
gcloud iam service-accounts keys create ./gke-${MEMBER_NAME}.json \
    --iam-account=${MEMBER_NAME}@${GCP_PROJECT}.iam.gserviceaccount.com \
    --project=${GCP_PROJECT} && \
\
gcloud projects add-iam-policy-binding ${GCP_PROJECT} \
    --member=serviceAccount:${MEMBER_NAME}@${GCP_PROJECT}.iam.gserviceaccount.com \
    --role=roles/editor
