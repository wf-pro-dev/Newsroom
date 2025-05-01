from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.models.db_hidden_base import hidden_base

class hidden_videos(hidden_base):
    """
    Association table that tracks which videos are hidden for which users.
    Inherits base functionality from hidden_base.
    """
    __tablename__ = 'hidden_videos'
    
    video_id = db.Column(db.Integer, db.ForeignKey("videos.id", ondelete="CASCADE"), nullable=False)
    
    # Add a unique constraint to ensure a user can't hide the same video multiple times
    __table_args__ = (
        db.UniqueConstraint('user_id', 'video_id', name='uq_user_video_hidden'),
    )
    
    def to_dict(self):
        base_dict = super().to_dict()
        base_dict.update({
            "video_id": self.video_id,
            "type": "video"
        })
        return base_dict
