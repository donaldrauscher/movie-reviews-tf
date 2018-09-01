## Classifying Movie Reviews with TensorFlow

Building a DNN classifier with TensorFlow for classifying movie reviews as positive or negative.  

Source: [ACL 2011 IMDB dataset](http://ai.stanford.edu/~amaas/data/sentiment/)

`serve_deploy.sh` deploys the exported model on Cloud ML Engine 
<br/>
`serve_test.sh` tests getting predictions from Cloud ML Engine

TODO: I used a version of this dataset that had already been preprocessed into TFRecords.  As part of this preprocessing, the reviews were lowercases and split into words; punctuation, including "'", were treated as seperate words.  To properly serve this model, we need to replicate this preprocessing in the [serving input receiver](https://www.tensorflow.org/guide/saved_model#prepare_serving_inputs).  Unfortunately, I couldn't find a way to do this with native TF ops!  I was able to replicate it with `tf.py_func`.  However, [a documentated limitation](https://www.tensorflow.org/api_docs/python/tf/py_func) of `py_func` is that it is *not* serialized in the GraphDef, so it can't be used for serving, which requires serializing the model and restoring in a different environment.  Still working on this.