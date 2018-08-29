#!/bin/bash

MODEL_NAME=movie_reviews
MODEL_VERSION=v1

gcloud ml-engine predict --model movie_reviews --version v1 --json-instances reviews.json
