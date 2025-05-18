from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from etl.extract import fetch_topics
from server.flask_server import app
from seeds.seed_topics import seed_topics
from database.operations import reset_all_tables, create_all_tables




def seed_runner(n_topics:int):
   
    # Reset the tables of the database
    reset_all_tables()
    create_all_tables()
    
    # Launch the content generation process
    seed_topics(fetch_topics(n_elem=n_topics))

if __name__ == "__main__":
    with app.app_context():
        seed_runner(5)
