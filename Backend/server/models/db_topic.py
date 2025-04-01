from sys import path
import os
from sqlalchemy import String
from sqlalchemy.dialects.postgresql import ARRAY

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

# etl import
from etl.extract import fetch_questions
from database.connection import db
from server.models.db_question import questions
from api.openai.client import fetch_image


class topics(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    role = db.Column(db.String(255), nullable=False)
    # img_urls = db.Column(ARRAY(String))

    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "role": self.role,
            # "img_urls": self.img_urls
        }

    def set_questions(self,n_qst:int=3) -> list[questions]:
        str_questions = fetch_questions(topic=self.title, role=self.role,n_qst=n_qst)
        
        return [
            questions(text=question, topic_id=self.id) for question in str_questions
        ]
    
    def __str__(self):
        return f"topic = {self.title} role = {self.role}"

    # def set_img_urls(self):
    #     self.img_urls = []
    #     for i in range(3):
    #         img_url = fetch_image(self.title,index=i)
    #         self.img_urls.append(img_url)

if __name__ == "__main__":
    print(backend_root)
