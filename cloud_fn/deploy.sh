#!/bin/bash
gcloud beta functions deploy classify_movie_reviews --runtime python37 --trigger-http --stage-bucket=gs://djr_cloud_functions/
