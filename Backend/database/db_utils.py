from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, '../../../'))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.app import create_app

app = create_app()


def drop_all_tables():
    """Drop all tables in the database."""
    with app.app_context():  # Add application context
        db.drop_all()
        print("All tables dropped.")


def create_all_tables():
    """Create all tables in the database."""
    with app.app_context():  # Add application context
        db.create_all()
        print("All tables created.")
