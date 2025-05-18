from sys import path
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from Backend.server.models.db_videos import videos
from database.connection import db

def seed_videos(videos:list[videos],question):

    for video in videos:
        video.question_id = question.id

        db.session.add(video)
        db.session.commit()
    
    print(f"Question ( id : {question.id} ) ( nb of videos : {len(videos)} )", "-" * 20, sep="\n")

        
