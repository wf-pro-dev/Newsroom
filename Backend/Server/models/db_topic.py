from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# etl import
from etl.extract import fetch_Questions

from database.connection import db
from Server.models.db_question import questions

class topics(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    role = db.Column(db.String(255), nullable=False)
    

    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "role": self.role,
        } 
        
    def set_questions(self) -> list[questions]:
        str_questions = fetch_Questions(topic=self.title, role=self.role)
        return [
            questions(text=question,topic=self.title, role=self.role)
            for question in str_questions
        ]