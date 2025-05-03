from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db


class videos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    question_id = db.Column(db.Integer, db.ForeignKey("questions.id"), nullable=False)
    youtube_id = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    thumbnail = db.Column(db.String(255), nullable=True)

    # Relationship with hidden_videos table
    hidden_for_users = db.relationship("hidden_videos",
                                    backref=db.backref("video", lazy=True),
                                    cascade="all, delete-orphan")

    def to_dict(self):
        return {
            "id": self.id,
            "question_id": self.question_id,
            "youtube_id": self.youtube_id,
            "description": self.description,
            "thumbnail": self.thumbnail,
        }

    def is_hidden_for_user(self, user_id):
        """Check if this video is hidden for a specific user"""
        return any(hidden.user_id == user_id for hidden in self.hidden_for_users)
