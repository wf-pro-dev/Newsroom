from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

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
