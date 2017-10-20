#NOTE: THis is a RESTful API demo using flask-restful for Python

from flask import Flask
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}

api.add_resource(HelloWorld, '/')

if __name__ == '__main__':
    app.run(debug=True)


"""
To Test:
1. Execute this file via python.
2. Open a new terminal and perform a curl call such as:
	curl http://127.0.0.1:5000/
3. See response is the return as:

{
    "hello": "world"
}
"""

