from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db


class articles(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Float, default=0)
    question_id = db.Column(db.Integer, db.ForeignKey("questions.id"), nullable=False)

    api_source = db.Column(db.String(50), nullable=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=True)
    content = db.Column(db.Text, nullable=True)
    url = db.Column(db.String(500), nullable=True)
    urlToImage = db.Column(db.String(500), nullable=True)
    publishedAt = db.Column(db.DateTime, nullable=True)

    def to_dict(self):
        return {
            "id": self.id,
            "score": self.score,
            "question_id": self.question_id,
            "title": self.title,
            "description": self.description,
            "content": self.content,
            "url": self.url,
            "urlToImage": self.urlToImage,
            "publishedAt": self.publishedAt,
            "api_source": self.api_source,
        }
