from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from typing import Any, List, Dict, Optional
from database.connection import get_db
from config.constants import COLUMNS

def create_table(table_name: str) -> None:
    """Creates a table if it doesn't exist."""
    if table_name not in COLUMNS:
        raise ValueError(f"Unknown table: {table_name}")
        
    columns = COLUMNS[table_name]
    columns_def = ", ".join([f"{col} TEXT" for col in columns])
    
    sql = f"""
    CREATE TABLE IF NOT EXISTS {table_name} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        {columns_def}
    )
    """
    
    db = get_db()
    db.execute(sql, is_select=False)

def delete_table(table_name: str) -> None:
    """Drops a table if it exists."""
    db = get_db()
    db.execute(f"DROP TABLE IF EXISTS {table_name}", is_select=False)

def delete_all_tables() -> None:
    """Drops all tables defined in COLUMNS."""
    for table in COLUMNS.keys():
        delete_table(table)

def insert_data(table_name: str, obj: Any) -> int:
    """
    Inserts data into specified table.
    Returns the ID of the inserted row.
    """
    if table_name not in COLUMNS:
        raise ValueError(f"Unknown table: {table_name}")
    
    obj_dict = obj.to_dict() if hasattr(obj, 'to_dict') else obj
    columns = COLUMNS[table_name]
    
    # Filter object dictionary to only include defined columns
    filtered_data = {k: obj_dict.get(k) for k in columns if k in obj_dict}
    
    placeholders = ", ".join(["?" for _ in filtered_data])
    columns_str = ", ".join(filtered_data.keys())
    
    sql = f"""
    INSERT INTO {table_name} ({columns_str})
    VALUES ({placeholders})
    """
    
    db = get_db()
    return db.execute(sql, tuple(filtered_data.values()), is_select=False)

def get_by_id(table_name: str, id: int) -> Optional[Dict]:
    """Retrieves a single row by ID."""
    db = get_db()
    results = db.execute(
        f"SELECT * FROM {table_name} WHERE id = ?",
        (id,)
    )
    results_list = list(results)
    return results_list[0] if results_list else None

def get_by_question_id(table_name: str, question_id: int) -> List[Dict]:
    """Retrieves all rows for a given question_id."""
    db = get_db()
    results = db.execute(
        f"SELECT * FROM {table_name} WHERE question_id = ?",
        (question_id,)
    )
    return list(results)

def get_all(table_name: str) -> List[Dict]:
    """Retrieves all rows from a table."""
    db = get_db()
    results = db.execute(f"SELECT * FROM {table_name}")
    return list(results)

def delete_by_id(table_name: str, id: int) -> None:
    """Deletes a row by ID."""
    db = get_db()
    db.execute(
        f"DELETE FROM {table_name} WHERE id = ?",
        (id,),
        is_select=False
    )

def show_table(table_name: str) -> None:
    """Prints all rows from a table (for debugging)."""
    rows = get_all(table_name)
    for row in rows:
        print(row)



def init(table_list=COLUMNS.keys()):
    for table in table_list:
        delete_table(table_name=table)
        create_table(table_name=table)
        print(f" init {table}")

if __name__ == "__main__" :
    init(["Fav_Articles","Fav_Videos"])
