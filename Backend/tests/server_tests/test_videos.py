from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, '../../../'))
backend_root = project_root + "/Backend"
path.append(backend_root)

import unittest
from flask import json
from server.app import create_app
from database.connection import db
from server.models.db_question import questions
from server.models.db_video import videos

class VideosTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['TESTING'] = True
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()
            self.client.post('/questions', json=questions(text='What is Flask?', keywords='Flask').to_dict())


    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()

    def test_get_videos(self):
        response = self.client.get('/videos')
        self.assertEqual(response.status_code, 200)

    def test_get_video_by_question_id(self):
        with self.app.app_context():
            video = videos(question_id=1, video_id="TestVideoID")
            db.session.add(video)
            db.session.commit()
        response = self.client.get('/videos/1')
        self.assertEqual(response.status_code, 200)
        self.assertIn('TestVideoID', str(response.data))

    def test_delete_video(self):
        with self.app.app_context():
            video = videos(question_id=1, video_id="TestVideoID")
            db.session.add(video)
            db.session.commit()
            video_id = video.id
        response = self.client.delete(f'/videos/{video_id}')
        self.assertEqual(response.status_code, 200)
        self.assertIn('deleted successfully', str(response.data))

    def test_delete_video_not_found(self):
        response = self.client.delete('/videos/999')
        self.assertEqual(response.status_code, 404)
        self.assertIn('Item not found', str(response.data))

if __name__ == '__main__':
    unittest.main()