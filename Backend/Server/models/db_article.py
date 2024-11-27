from database.connection import db

class articles(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Float, default=0)
    question_id = db.Column(db.Integer, nullable=False)
    
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
        
class fav_articles(db.Model):
    
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Float, default=0)
    question_id = db.Column(db.Integer, nullable=False)
    obj_id = db.Column(db.Integer, nullable=True)
    
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