from sys import path
import os
from datetime import datetime

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db

class hidden_base(db.Model):
    """
    Base abstract class for hiding content from users.
    This class is not meant to be instantiated directly but to be inherited from.
    """
    __abstract__ = True  # This tells SQLAlchemy not to create a table for this model
    
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    
    def to_dict(self):
        """Basic dictionary representation to be extended by child classes"""
        return {
            "id": self.id,
            "user_id": self.user_id,
        }
