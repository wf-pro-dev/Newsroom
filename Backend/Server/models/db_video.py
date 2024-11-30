from database.connection import db


class videos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    question_id = db.Column(db.Integer, db.ForeignKey("questions.id"), nullable=False)
    video_id = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    thumbnail = db.Column(db.String(255), nullable=True)

    def to_dict(self):
        return {
            "id": self.id,
            "question_id": self.question_id,
            "video_id": self.video_id,
            "description": self.description,
            "thumbnail": self.thumbnail,
        }
