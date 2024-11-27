from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

import sqlite3
import pandas as pd
from sqlalchemy import create_engine, inspect
from config.constants import DATABASE_URI

# Read from SQLite
sqlite_conn = sqlite3.connect('test_db.db')
sqlite_cursor = sqlite_conn.cursor()

# Connect to PostgreSQL
pg_engine = create_engine(DATABASE_URI)
inspector = inspect(pg_engine)


# Get table names
sqlite_cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = sqlite_cursor.fetchall()

# Transfer each table
for table in tables:
    print(table)
    table_name = table[0]
    df = pd.read_sql_query(f'SELECT * FROM {table_name}', sqlite_conn)
    df.to_sql(table_name, pg_engine, if_exists='replace', index=False)

table_names = inspector.get_table_names()
print(table_names)

sqlite_conn.close()