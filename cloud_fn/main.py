
# gets predictions from cloud ml engine
def classify_movie_reviews(request):
    import flask
    import json
    import re
    import math
    import googleapiclient.discovery
    import google.auth

    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST',
        'Access-Control-Allow-Headers': 'Content-Type'
    }

    # handle pre-flight options request
    if request.method == 'OPTIONS':
        return flask.make_response(('', 204, headers))

    _, project = google.auth.default()

    request_json = request.get_json()

    # this pulls out our proper nouns and treats them as single words
    def preprocessing(review):
        proper = r"([A-Z]([a-z]+|\.)(?:\s+[A-Z]([a-z]+|\.))*(?:\s+[a-z][a-z\-]+){0,2}\s+[A-Z]([a-z]+|\.)(?:\s+[0-9]+)?)"
        space_between_brackets = r"[\.\s]+(?=[^\[\]]*]])"
        brackets = r"(?:[\[]{2})(.*?)(?:[\]]{2})"

        review = re.sub(proper, '[[\\1]]', review)
        review = re.sub(space_between_brackets, '~', review)
        review = re.sub(brackets, '\\1', review)
        return review

    model = 'movie_reviews'
    version = request_json['version']
    instances = [preprocessing(i) for i in request_json['instances']]

    service = googleapiclient.discovery.build('ml', 'v1')
    name = 'projects/{}/models/{}/versions/{}'.format(project, model, version)

    response = service.projects().predict(
        name=name,
        body={'instances': instances}
    ).execute()

    if 'error' in response:
        raise RuntimeError(response['error'])

    # clear out nan if they exist
    for r in response['predictions']:
        if all([math.isnan(i) for i in r['prob']]):
            r['prob'] = []
            r['class'] = -1

    return flask.make_response((
        json.dumps(response['predictions']),
        200,
        headers
    ))
