from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from seeds.seed_topics import seed_topics
from etl.extract import fetch_topics


def seed_runner(n_topics:int):
    seed_topics(fetch_topics(n_elem=n_topics))