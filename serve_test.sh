#!/bin/bash

MODEL_NAME=movie_reviews

gcloud ml-engine predict --model $MODEL_NAME --json-instances reviews.ndjson
