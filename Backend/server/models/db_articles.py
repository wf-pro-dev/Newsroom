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
    question_id = db.Column(db.Integer, db.ForeignKey("questions.id", ondelete="SET NULL"), nullable=True)

    api_source = db.Column(db.String(50), nullable=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=True)
    content = db.Column(db.Text, nullable=True)
    url = db.Column(db.Text, nullable=True)
    urlToImage = db.Column(db.Text, nullable=True)
    publishedAt = db.Column(db.DateTime, nullable=True)
    
    # Relationship with hidden_articles table
    hidden_for_users = db.relationship("hidden_articles",
                                    backref=db.backref("article", lazy=True),
                                    cascade="all, delete-orphan")

    # Relationship with fav_articles
    favorites_articles = db.relationship("fav_articles",
                                       back_populates="article",
                                       lazy=True,
                                       cascade="all, delete-orphan")

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

    def is_hidden_for_user(self, user_id):
        """Check if this article is hidden for a specific user"""
        return any(hidden.user_id == user_id for hidden in self.hidden_for_users)
