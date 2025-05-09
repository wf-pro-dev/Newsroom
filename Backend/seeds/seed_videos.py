from sys import path
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.models.db_video import videos
from database.connection import db

def seed_videos(videos:list[videos],question):

    for video in videos:
        video.question_id = question.id

        db.session.add(video)
        db.session.commit()
    
        print(f"Video with id = {video.id} is complete", "-" * 20, sep="\n")

        
