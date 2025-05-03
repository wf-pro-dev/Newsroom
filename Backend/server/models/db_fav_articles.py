from sys import path
import os
from datetime import datetime

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db

class fav_articles(db.Model):
    __tablename__ = 'fav_articles'
    
    # Primary key for this table (independent from articles)
    id = db.Column(db.Integer, primary_key=True)
    
    # Article data (duplicated to preserve even if original article is deleted)
    score = db.Column(db.Float, default=0)
    question_id = db.Column(db.Integer, nullable=True)
    api_source = db.Column(db.String(50), nullable=True)
    title = db.Column(db.String(255), nullable=False)
    description = db.Column(db.Text, nullable=True)
    content = db.Column(db.Text, nullable=True)
    url = db.Column(db.Text, nullable=True)
    urlToImage = db.Column(db.Text, nullable=True)
    publishedAt = db.Column(db.DateTime, nullable=True)
   
    # Reference to article (with ondelete="SET NULL" to keep favorite when article is deleted)
    article_id = db.Column(db.Integer, db.ForeignKey('articles.id', ondelete="SET NULL"), nullable=True)
    
    article = db.relationship("articles", foreign_keys=[article_id], backref=db.backref("fav_articles", lazy=True))

    # Favorite-specific fields
    user_id = db.Column(db.Integer, db.ForeignKey("users.id", ondelete="CASCADE"), nullable=False) 
    
    def to_dict(self):
        return {
            "id": self.id,
            "article_id": self.article_id,
            "score": self.score,
            "question_id": self.question_id,
            "title": self.title,
            "description": self.description,
            "content": self.content,
            "url": self.url,
            "urlToImage": self.urlToImage,
            "publishedAt": self.publishedAt,
            "api_source": self.api_source,
            "user_id": self.user_id,
        }
