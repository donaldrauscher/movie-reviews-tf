#!/bin/bash

MODEL_NAME=movie_reviews
MODEL_VERSION=v1
MODEL_TIMESTAMP=$(ls -t exports/ | head -1)

DEPLOYMENT_SOURCE=gs://djr-data/movie-reviews

gsutil rsync -c -d -r exports/$MODEL_TIMESTAMP $DEPLOYMENT_SOURCE

gcloud ml-engine models create $MODEL_NAME

gcloud ml-engine versions create $MODEL_VERSION --model $MODEL_NAME --origin $DEPLOYMENT_SOURCE \
    --python-version 3.5 --runtime-version 1.9
