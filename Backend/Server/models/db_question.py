from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# etl import
from etl.extract import fetch_Articles, fetch_Videos
from etl.transform import generate_Query, generate_Articles, generate_Videos

from database.connection import db

class questions(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String(255), nullable=False)
    topic = db.Column(db.String(255), nullable=False)
    role = db.Column(db.String(255), nullable=False)
    keywords = db.Column(db.String(255), nullable=False)


    def to_dict(self):
        return {
            "id": self.id,
            "text": self.text,
            "topic": self.topic,
            "role": self.role,
        }

    def set_articles(self,query:dict):
        raw_articles = fetch_Articles(query=query)
        return generate_Articles(raw_articles)
    
    def set_videos(self,query:dict):
        raw_videos = fetch_Videos(query=query)
        return generate_Videos(raw_videos)
    