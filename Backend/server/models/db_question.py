from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

# etl import
from etl.extract import fetch_articles, fetch_videos
from etl.transform import generate_articles, generate_videos

from database.connection import db


class questions(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    topic_id = db.Column(db.Integer, db.ForeignKey("topics.id"))
    text = db.Column(db.String(255), nullable=False)
    keywords = db.Column(db.String(255), nullable=False)

    def to_dict(self):
        return {
            "id": self.id,
            "topic_id": self.topic_id,
            "text": self.text,
            "keywords": self.keywords,
        }

    def set_articles(self, query: dict):
        raw_articles = fetch_articles(query=query)
        return generate_articles(raw_articles)

    def set_videos(self, query: dict):
        raw_videos = fetch_videos(query=query)
        return generate_videos(raw_videos)

if __name__ == "__main__":
    query = {"NewsAPI" : "Tech","NewsDATA": "Tech" }
    question = questions(topic_id=1, text="What will i do", keywords="Lourd, le, Q")
    question.set_articles(query=query)