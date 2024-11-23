from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")


def execute(db_conn, sql_command: str, params=None):
    cursor = db_conn.cursor()
    if params:
        cursor.execute(sql_command, params)
    else:
        cursor.execute(sql_command)
    db_conn.commit()
    return cursor.lastrowid

def create_table(db_conn, table_name: str):
    sql_command = f"CREATE TABLE IF NOT EXISTS {table_name} (id INTEGER PRIMARY KEY, { ', '.join([f'{col_name} TEXT' for col_name in COLUMNS[table_name]]) })"
    execute(db_conn, sql_command)

def insert_data(db_conn, table_name: str, obj):
    
    columns = ', '.join(COLUMNS[table_name])
   # Create placeholders for parameterized query
    placeholders = ', '.join(['?' for _ in COLUMNS[table_name]])
    # Get values in the same order as columns
    obj_to_dict = obj.to_dict()
    if(table_name == "Videos"): print(table_name,obj_to_dict)
    values = [obj_to_dict[key] for key in COLUMNS[table_name]]
    
    sql_command = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
    return execute(db_conn, sql_command, values)



def delete_all_tables(db_conn):
    """Deletes all tables from a specified SQLite database."""

    cursor = db_conn.cursor()

    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = [table[0] for table in cursor.fetchall()]

    for table in tables:
        execute(db_conn=db_conn,sql_command=f"DROP TABLE IF EXISTS {table};")

def delete_table(db_conn,table_name):
    """Deletes all tables from a specified SQLite database."""


    execute(db_conn=db_conn,sql_command=f"DROP TABLE IF EXISTS {table_name};")

    

def show_table(db_conn, table_name: str):
    sql_command = f"SELECT * FROM {table_name}"
    cursor = db_conn.cursor()
    cursor.execute(sql_command)
    rows = cursor.fetchall()
    for row in rows:
        print(row)
        
if __name__ == "__main__":
    
    articles = {
        "score": "4.5",
        "title": "New AI Breakthrough in Natural Language Processing",
        "description": "Researchers develop more efficient language models",
        "content": "A team of researchers has announced a significant breakthrough in NLP...",
        "url": "https://tech-news.com/ai-breakthrough",
        "urlToImage": "https://tech-news.com/images/ai-cover.jpg",
        "publishedAt": "2024-03-20T14:30:00Z",
        "api_source": "TechNews API"
    }
    
    questions = {
        "question": "What are the implications of this AI breakthrough?",
        "topic": "Artificial Intelligence",
        "role": "Technology Analyst",
        "keywords": "AI, NLP, machine learning, research"
    }
    
    topics = {
        "title_top": "AI and Machine Learning Advances",
        "role_top": "Tech Research"
    }
    print(insert_data(0,"Questions",questions))

