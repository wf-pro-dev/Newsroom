from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

COLUMNS = {
        "Articles": [
            "score",
            "question_id",
            "title",
            "description",
            "content",
            "url",
            "urlToImage",
            "publishedAt",
            "api_source"
        ],
        
        "Favorites": [
            "score",
            "title",
            "description",
            "content",
            "url",
            "urlToImage",
            "publishedAt",
            "api_source"
        ],
        
        "Questions": [
            "question",
            "topic",
            "role",
            "keywords",
        ],
       
        "Topics": [
            "title_top",
            "role_top"
        ]
    }

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
    values = [obj_to_dict[key] for key in COLUMNS[table_name]]
    
    sql_command = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
    return execute(db_conn, sql_command, values)

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

