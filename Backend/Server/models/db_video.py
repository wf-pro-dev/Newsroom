from database.connection import db

class videos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    question_id = db.Column(db.Integer, nullable=False)
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
        

class fav_videos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    obj_id = db.Column(db.Integer, nullable=False)
    question_id = db.Column(db.Integer, nullable=False)
    video_id = db.Column(db.String(255), nullable=False)
    description = db.Column(db.String(255), nullable=True)
    thumbnail = db.Column(db.String(255), nullable=True)
    orientation = db.Column(db.String(50), nullable=True)

    def to_dict(self):
        return {
            "id": self.id,
            "question_id": self.question_id,
            "video_id": self.video_id,
            "description": self.description,
            "thumbnail": self.thumbnail,
        } 