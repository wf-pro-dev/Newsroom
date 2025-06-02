from sys import path
import os
from datetime import datetime

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db


class fav_videos(db.Model):

    id = db.Column(db.Integer, primary_key=True)
    
    favAt = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

    question_id = db.Column(db.Integer , nullable=True)
    youtube_id = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    thumbnail = db.Column(db.String(255), nullable=True)
    
    # Reference to video (with ondelete="SET NULL" to keep favorite when video is deleted)
    video_id = db.Column(db.Integer, db.ForeignKey('videos.id', ondelete="SET NULL"), nullable=True)
    
    video = db.relationship("videos", foreign_keys=[video_id], back_populates="favorites_videos")

    # Favorite-specific fields
    user_id = db.Column(db.Integer, db.ForeignKey("users.id", ondelete="CASCADE"), nullable=False) 

    def to_dict(self):
        return {
            "id": self.id,
            "favAt" : self.favAt,
            "youtube_id": self.youtube_id,
            "video_id": self.video_id,
            "question_id": self.question_id,
            "video_id": self.video_id,
            "description": self.description,
            "thumbnail": self.thumbnail,
            "user_id":self.user_id
        }

