""" Test the app """

import unittest
import json
from app import app

class TestApp(unittest.TestCase):
    """
    Test the app
    """

    def setUp(self):
        """
        Set up the test client
        """
        self.app = app.test_client()

    def test_get_tasks(self):
        """
        Test get all tasks
        """
        response = self.app.get('/tasks')
        self.assertEqual(response.status_code, 200)

    def test_add_task(self):
        """
        Test add a task
        """
        response = self.app.post('/tasks', json={
            'title': 'Test task',
            'description': 'Test description'
        })
        self.assertEqual(response.status_code, 201)
        self.assertEqual(json.loads(response.get_data()), {
            'id': 1,
            'title': 'Test task',
            'description': 'Test description'
        })

if __name__ == '__main__':
    unittest.main()
