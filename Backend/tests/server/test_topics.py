import unittest
from flask import json
from server.app import create_app
from database.connection import db
from server.models.db_topic import topics
from etl.extract import fetch_Topics

class TopicsRoutesTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()
            

    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()

    def test_get_topics(self):
        response = self.client.get('/topics')
        self.assertEqual(response.status_code, 200)

    def test_get_topic_by_id(self):
        with self.app.app_context():
            topic = topics(title="Test Topic", role="Test Role")
            db.session.add(topic)
            db.session.commit()
            topic_id = topic.id
        response = self.client.get(f'/topics/{topic_id}')
        self.assertEqual(response.status_code, 200)
        self.assertIn('Test Topic', str(response.data))

    def test_get_topic_by_id_not_found(self):
        response = self.client.get('/topics/999')
        self.assertEqual(response.status_code, 404)
        self.assertIn('error', str(response.data))

    def test_add_topic(self):
        # Mock the fetch_Topics function if necessary
        response = self.client.post('/topics', json={"topic":"Test Topic","role":"Test Role"})
        
        self.assertEqual(response.status_code, 201)
        self.assertIn('Test Topic', str(response.data))

    def test_add_topic_invalid(self):
        response = self.client.post('/topics', json={})
        self.assertEqual(response.status_code, 400)
        self.assertIn('error', str(response.data))

if __name__ == '__main__':
    unittest.main()