#!/bin/bash

MODEL_NAME=movie_reviews
MODEL_VERSION=v3

gcloud ml-engine predict --model $MODEL_NAME --version $MODEL_VERSION --json-instances reviews.ndjson
