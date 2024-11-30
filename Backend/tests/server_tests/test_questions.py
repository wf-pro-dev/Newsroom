from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

import unittest
from flask import json
from server.app import create_app
from database.connection import db
from server.models.db_question import questions

class QuestionsTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()  # Create the database tables

    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()  # Drop the database tables

    def test_add_question(self):
        # Test adding a new question
        response = self.client.post('/questions', json=questions(text='What is Flask?', keywords='Flask').to_dict())
        self.assertEqual(response.status_code, 201) 
        self.assertIn('What is Flask?', str(response.data))

    def test_get_questions(self):
        # Test retrieving all questions
        self.client.post('/questions', json=questions(text='What is Flask?', keywords='Flask').to_dict())
        response = self.client.get('/questions')
        self.assertEqual(response.status_code, 200)
        self.assertIn('What is Flask?', str(response.data))

    def test_get_question_by_id(self):
        # Test retrieving a specific question by ID
        post_response = self.client.post('/questions', json=questions(text='What is Flask?', keywords='Flask').to_dict())
        question_id = json.loads(post_response.data)['id']
        response = self.client.get(f'/questions/{question_id}')
        self.assertEqual(response.status_code, 200)
        self.assertIn('What is Flask?', str(response.data))

    def test_add_question_invalid(self):
        # Test adding a question with missing data
        response = self.client.post('/questions', json={})
        self.assertEqual(response.status_code, 400)
        self.assertIn('error', str(response.data))

if __name__ == '__main__':
    unittest.main()