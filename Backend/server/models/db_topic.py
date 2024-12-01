from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, '../../../'))
backend_root = project_root + "/Backend"
path.append(backend_root)

# etl import
from etl.extract import fetch_Questions

from database.connection import db
from server.models.db_question import questions


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
            questions(text=question, topic_id=self.id) for question in str_questions
        ]
        
if __name__ == "__main__":
    print(backend_root)
