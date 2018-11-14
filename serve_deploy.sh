#!/bin/bash

MODEL_NAME=movie_reviews
MODEL_VERSION=v5
MODEL_TIMESTAMP=$(ls -t exports/ | head -1)

DEPLOYMENT_SOURCE=gs://djr-data/movie-reviews

gsutil rsync -c -d -r exports/$MODEL_TIMESTAMP $DEPLOYMENT_SOURCE

#gcloud ml-engine models create $MODEL_NAME

gcloud ml-engine versions create $MODEL_VERSION --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --python-version 2.7 --runtime-version 1.10

gcloud ml-engine versions set-default $MODEL_VERSION --model $MODEL_NAME
