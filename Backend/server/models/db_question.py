from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# etl import
from etl.extract import fetch_Articles, fetch_Videos
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
        raw_articles = fetch_Articles(query=query)
        return generate_articles(raw_articles)

    def set_videos(self, query: dict):
        raw_videos = fetch_Videos(query=query)
        return generate_videos(raw_videos)
