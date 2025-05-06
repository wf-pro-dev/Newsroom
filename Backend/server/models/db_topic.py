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
from api.genai.client import fetch_prompt_image_gen_ai,fetch_image_gen_ai
from api.replicate.client import generate_image_replicate


class topics(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    role = db.Column(db.String(255), nullable=False)
    images = db.Column(ARRAY(String))

    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "role": self.role,
            "images": self.images
        }

    def set_questions(self,n_qst:int=3) -> list[questions]:
        str_questions = fetch_questions(topic=self.title, role=self.role,n_qst=n_qst)
        
        return [
            questions(text=question, topic_id=self.id) for question in str_questions
        ]
        
    def set_images(self):
        list_prompts = fetch_prompt_image_gen_ai(self.title)
        images = []
        for i ,prompt in enumerate(list_prompts):
            img_url = ""
            try:
                img_url = generate_image_replicate(prompt=prompt, topic_id=self.id, index=i)
            except Exception as e:
                print(f"ERROR generating image with Replicate : {e}")
                img_url = fetch_image_gen_ai(prompt=prompt, topic_id=self.id, index=i)

            images.append(img_url)
        
        self.images = images
        
    
    def __str__(self) -> str:
        return f"topic = {self.title} role = {self.role}"       

if __name__ == "__main__":
    print(backend_root)
