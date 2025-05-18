"""
This module contains unit tests for the articles API endpoints.
"""

import os
import unittest
from sys import path

# Add the Backend directory to the system path
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.server import create_app
from server.models.db_question import questions
from Backend.server.models.db_articles import articles
from database.connection import db


class ArticlesTestCase(unittest.TestCase):
    """Test case for the articles API endpoints."""

    def setUp(self):
        self.app = create_app()
        self.app.config["TESTING"] = True
        self.client = self.app.test_client()
        with self.app.app_context():
            db.create_all()
            self.client.post(
                "/questions",
                json=questions(text="What is Flask?", keywords="Flask").to_dict(),
            )

    def tearDown(self):
        with self.app.app_context():
            db.session.remove()
            db.drop_all()

    def test_get_articles(self):
        """Test the GET request for retrieving all articles."""
        response = self.client.get("/articles")
        self.assertEqual(response.status_code, 200)

    def test_get_article_by_question_id(self):
        """Test the GET request for retrieving all articles by question id."""
        with self.app.app_context():
            article = articles(question_id=1, title="Test Article")
            db.session.add(article)
            db.session.commit()
        response = self.client.get("/articles/1")
        self.assertEqual(response.status_code, 200)
        self.assertIn("Test Article", str(response.data))

    def test_delete_article(self):
        """Test the DELETE request for retrieving all articles."""
        with self.app.app_context():
            article = articles(question_id=1, title="Test Article")
            db.session.add(article)
            db.session.commit()
            article_id = article.id
        response = self.client.delete(f"/articles/{article_id}")
        self.assertEqual(response.status_code, 200)
        self.assertIn("deleted successfully", str(response.data))

    def test_delete_article_not_found(self):
        """Test the DELETE request for retrieving all articles."""
        response = self.client.delete("/articles/999")
        self.assertEqual(response.status_code, 404)
        self.assertIn("Item not found", str(response.data))


if __name__ == "__main__":
    unittest.main()
