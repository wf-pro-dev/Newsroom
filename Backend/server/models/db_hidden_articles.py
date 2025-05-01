from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.models.db_hidden_base import hidden_base

class hidden_articles(hidden_base):
    """
    Association table that tracks which articles are hidden for which users.
    Inherits base functionality from hidden_base.
    """
    __tablename__ = 'hidden_articles'
    
    article_id = db.Column(db.Integer, db.ForeignKey("articles.id", ondelete="CASCADE"), nullable=False)
    
    # Add a unique constraint to ensure a user can't hide the same article multiple times
    __table_args__ = (
        db.UniqueConstraint('user_id', 'article_id', name='uq_user_article_hidden'),
    )
    
    def to_dict(self):
        base_dict = super().to_dict()
        base_dict.update({
            "article_id": self.article_id,
            "type": "article"
        })
        return base_dict
