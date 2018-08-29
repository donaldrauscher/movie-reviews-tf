## Classifying Movie Reviews with TensorFlow

Building a DNN classifier with TensorFlow for classifying movie reviews as positive or negative.  

Source: [ACL 2011 IMDB dataset](http://ai.stanford.edu/~amaas/data/sentiment/)

`serve_deploy.sh` deploys the exported model on Cloud ML Engine
`serve_test.sh` tests getting predictions from Cloud ML Engine

TODO:
* Add learning rate annealing in model itself ([example](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/examples/learn/iris_custom_decay_dnn.py))
* Add Cloud Function to serve predictions from Cloud ML Engine ([template](https://github.com/GoogleCloudPlatform/python-docs-samples/blob/master/ml_engine/online_prediction/predict.py))
