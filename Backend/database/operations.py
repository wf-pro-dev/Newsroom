import os
import sys

# Add proper relative import paths
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, ".."))
sys.path.append(project_root)

# Import modules using the correct paths
from server.app import create_app
from database.connection import db 


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

if __name__ == "__main__":
    # drop_all_tables()
    create_all_tables()
