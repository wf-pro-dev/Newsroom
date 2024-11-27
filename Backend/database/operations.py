from sys import path
from psycopg2 import connect, sql  # Import PostgreSQL connection

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from typing import Any, List, Dict, Optional
from database.connection import get_db
from config.constants import COLUMNS




def create_table(table_name: str) -> None:
    """Creates a table if it doesn't exist."""
    if table_name not in COLUMNS:
        raise ValueError(f"Unknown table: {table_name}")

    columns_def = ", ".join([f"{col} TEXT" for col in COLUMNS[table_name]])
    sql = f"CREATE TABLE IF NOT EXISTS {table_name} (id SERIAL PRIMARY KEY, {columns_def})"

    with db.cursor() as cursor:
        cursor.execute(sql)
        cursor.connection.commit()  # Commit the transaction


def delete_table(table_name: str) -> None:
    """Drops a table if it exists."""
    with db.cursor() as cursor:
        cursor.execute(f"DROP TABLE IF EXISTS {table_name}")
        cursor.connection.commit()  # Commit the transaction


def insert_data(table_name: str, obj: Any) -> int:
    """Inserts data into specified table and returns the ID of the inserted row."""
    if table_name not in COLUMNS:
        raise ValueError(f"Unknown table: {table_name}")

    filtered_data = {k: obj.to_dict().get(k) for k in COLUMNS[table_name] if hasattr(obj, "to_dict") and k in obj.to_dict()}
    placeholders = ", ".join(["%s"] * len(filtered_data))
    columns_str = ", ".join(filtered_data.keys())

    sql = f"INSERT INTO {table_name} ({columns_str}) VALUES ({placeholders}) RETURNING id;"

    with db.cursor() as cursor:
        cursor.execute(sql, tuple(filtered_data.values()))
        cursor.connection.commit()  # Commit the transaction
        return cursor.fetchone()[0]  # Get the inserted ID


def delete_by_id(table_name: str, id: int) -> None:
    """Deletes a row by ID."""
    with db.cursor() as cursor:
        cursor.execute(f"DELETE FROM {table_name} WHERE id = %s", (id,))
        cursor.connection.commit()  # Commit the transaction


def show_table(table_name: str) -> None:
    """Prints all rows from a table (for debugging)."""
    rows = get_all(table_name)
    for row in rows:
        print(row)


def init(table_list=COLUMNS.keys()):
    """Initializes the database by deleting and creating tables."""
    for table in table_list:
        delete_table(table)
        create_table(table)
        print(f"Initialized {table}")


def get_all(table_name: str) -> List[Dict]:
    """Retrieves all rows from a specified table."""
    with db.cursor() as cursor:
        cursor.execute(f"SELECT * FROM {table_name};")
        columns = [desc[0] for desc in cursor.description]  # Get column names
        return [dict(zip(columns, row)) for row in cursor.fetchall()]  # Return rows as dictionaries


def get_by_id(table_name: str, id: int) -> Optional[Dict]:
    """Retrieves a single row by ID."""
    with db.cursor() as cursor:
        cursor.execute(f"SELECT * FROM {table_name} WHERE id = %s;", (id,))
        row = cursor.fetchone()
        if row:
            columns = [desc[0] for desc in cursor.description]
            return dict(zip(columns, row))  # Return the row as a dictionary
        return None  # Return None if no row found


def get_by_question_id(table_name: str, question_id: int) -> List[Dict]:
    """Retrieves all rows for a given question_id."""
    with db.cursor() as cursor:
        cursor.execute(f"SELECT * FROM {table_name} WHERE question_id = %s;", (question_id,))
        columns = [desc[0] for desc in cursor.description]
        return [dict(zip(columns, row)) for row in cursor.fetchall()]  # Return rows as dictionaries


if __name__ == "__main__":
    init(["Fav_Articles", "Fav_Videos"])
