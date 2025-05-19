import os
import sys
from sqlalchemy import text

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
    with app.app_context():
        # Drop the filtered tables with cascade to handle constraints
        db.metadata.drop_all(bind=db.engine)
        print(f"All tables dropped")

def reset_all_tables():
    """Drop all tables in the database while preserving favorites."""
    with app.app_context():
        # Get all table names from metadata
        all_tables = db.metadata.tables.keys()
        
        excluded_table_name = ["fav_videos", "fav_articles", "users"]
        
        # First, drop foreign key constraints
        with db.engine.connect() as conn:
            # Drop foreign key constraints
            conn.execute(text("ALTER TABLE fav_videos DROP CONSTRAINT IF EXISTS fav_videos_video_id_fkey"))
            conn.execute(text("ALTER TABLE fav_articles DROP CONSTRAINT IF EXISTS fav_articles_article_id_fkey"))
            conn.commit()

        # Filter out excluded tables
        tables_to_drop = [db.metadata.tables[name] for name in all_tables 
                         if name not in excluded_table_name]
        
        # Drop the filtered tables with cascade to handle constraints
        db.metadata.drop_all(bind=db.engine, tables=tables_to_drop)
        print(f"All tables dropped except: {', '.join(excluded_table_name)}")

def create_all_tables():
    """Create all tables in the database."""
    with app.app_context():  # Add application context
        db.create_all()
        print("All tables created.")

if __name__ == "__main__":
    drop_all_tables()
    create_all_tables()
