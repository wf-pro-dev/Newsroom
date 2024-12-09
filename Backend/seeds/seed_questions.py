from sys import path
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from seeds.seed_articles import seed_articles
from seeds.seed_videos import seed_videos
from server.models.db_question import questions
from database.connection import db
from etl.transform import generate_query

def seed_questions(questions:list[questions],topic):
    
    for qst in questions:
        qst.topic_id = topic.id

        keywords, query = generate_query(
        (topic.title, topic.role), qst.text
        )

        qst.keywords = keywords
        db.session.add(qst)
        db.session.commit()

        seed_articles(qst.set_articles(query=query),qst)
        seed_videos(qst.set_videos(query=query),qst)
        
        print(
            f"Question with id = {qst.id} is complete", "-" * 20, sep="\n"
        )
        
