from sys import path
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from seed_questions import seed_questions
from server.models.db_topic import topics
from database.connection import db


def seed_topics(list_topic:list):
    print(list_topic)
    for obj_topic in list_topic:

        topic = topics(title=obj_topic["topic"], role=obj_topic["role"])
        
        
        print(topic)
        db.session.add(topic)
        db.session.commit()
        
        topic.set_images()
        db.session.commit()

        seed_questions(questions=topic.set_questions(),topic=topic)
