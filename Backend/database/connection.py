import sqlite3, os
from typing import Optional, Any, List, Dict
from pathlib import Path

from config.constants import TEST_MODE

class DatabaseConnection:
    """
    Database connection manager for the Newsroom application.
    Handles connections to both main and test databases.
    """
    
    def __init__(self):
        self.base_path = Path(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
        self.db_folder = self.base_path / 'Backend' / 'data'
        # Ensure database directory exists
        self.db_folder.mkdir(parents=True, exist_ok=True)
        
        # Database paths
        self.main_db_path = self.db_folder / 'main_db.db'
        self.test_db_path = self.db_folder / 'test_db.db'
        
        self.conn: Optional[sqlite3.Connection] = None
        self.is_test_mode = TEST_MODE

    def dict_factory(self, cursor: sqlite3.Cursor, row: tuple) -> dict:
        """Convert database row to dictionary."""
        d = {}
        for idx, col in enumerate(cursor.description):
            d[col[0]] = row[idx]
        return d

    def connect(self, test_mode: bool = False) -> sqlite3.Connection:
        """Create a database connection."""
        
        db_path = self.test_db_path if self.is_test_mode else self.main_db_path
        print("db_path",db_path, self.is_test_mode == False)
        self.conn = sqlite3.connect(str(db_path))
        self.conn.row_factory = self.dict_factory
        return self.conn

    def execute(self, sql: str, params: tuple = None, is_select: bool = True) -> Any:
        """Execute SQL query and return results."""
        if not self.conn:
            self.connect()
           
        try:
            cursor = self.conn.cursor()
            if params:
                cursor.execute(sql, params)
            else:
                cursor.execute(sql)
            
            
            if is_select:
                return cursor.fetchall()
            else:
                self.conn.commit()
                return cursor.lastrowid
                
        except sqlite3.Error as e:
            self.conn.rollback()
            raise DatabaseError(f"Database error occurred: {str(e)}")

    def close(self):
        """Close the database connection."""
        if self.conn:
            self.conn.close()
            self.conn = None

    def __enter__(self):
        """Context manager entry."""
        return self.connect()

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit."""
        self.close()

class DatabaseError(Exception):
    """Custom exception for database errors."""
    pass

# Create singleton instance
db = DatabaseConnection()

def get_db() -> DatabaseConnection:
    """Get database connection instance."""
    if db.conn is None:
        db.connect()
    return db
