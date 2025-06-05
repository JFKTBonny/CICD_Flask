""" A simple todo application """
from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = []

@app.route('/tasks', methods=['GET'])
def get_tasks():
    """
    Get all tasks
    """
    return jsonify({'tasks': tasks})

# Route for getting a single task
@app.route('/tasks', methods=['POST'])
def add_task():
    """
    Add a task
    """
    task = {
        'id': len(tasks) + 1,
        'title': request.json['title'],
        'description': request.json['description'],
    }
    tasks.append(task)
    return jsonify(task), 201

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
