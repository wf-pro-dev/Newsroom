import unittest
from flask import json
from server.app import create_app
from database.connection import db

from server.models.db_question import questions
from server.models.db_article import articles

class ArticlesTestCase(unittest.TestCase):
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

    def test_get_articles(self):
        response = self.client.get('/articles')
        self.assertEqual(response.status_code, 200)

    def test_get_article_by_question_id(self):
        with self.app.app_context():
            article = articles(question_id=1, title="Test Article")
            db.session.add(article)
            db.session.commit()
        response = self.client.get('/articles/1')
        self.assertEqual(response.status_code, 200)
        self.assertIn('Test Article', str(response.data))

    def test_delete_article(self):
        with self.app.app_context():
            article = articles(question_id=1, title="Test Article")
            db.session.add(article)
            db.session.commit()
            article_id = article.id
        response = self.client.delete(f'/articles/{article_id}')
        self.assertEqual(response.status_code, 200)
        self.assertIn('deleted successfully', str(response.data))

    def test_delete_article_not_found(self):
        response = self.client.delete('/articles/999')
        self.assertEqual(response.status_code, 404)
        self.assertIn('Item not found', str(response.data))

if __name__ == '__main__':
    unittest.main()