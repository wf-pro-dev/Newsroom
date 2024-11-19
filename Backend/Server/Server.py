from sys import path
path.append('/Users/williamfotso/Workspace/Newsroom/Backend/Database')

from flask import Flask, jsonify, request, abort
from sqlite3 import connect, Error as SQLiteError
from flask_cors import CORS



app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:3000", "methods": ["GET", "POST", "DELETE", "OPTIONS"]}})
app.config["DEBUG"] = True



# <file>.db path
main_db= r'/Users/williamfotso/Workspace/Newsroom/Backend/DB_Files/main_db.db'
test_db= r'/Users/williamfotso/Workspace/Newsroom/Backend/DB_Files/test_db.db'

# [CREATE] [>>> execute()]
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

def execute(sql, isSelect=True, params=None):
    try:
        conn = connect(test_db)
        conn.row_factory = dict_factory
        cur = conn.cursor()
        if isSelect:
            return cur.execute(sql, params or ()).fetchall()
        else:
            result = cur.execute(sql, params or ())
            conn.commit()
            return result
    except SQLiteError as e:
        app.logger.error(f"Database error: {e}")
        abort(500, description="Database error occurred")
    finally:
        if conn:
            conn.close()



@app.route('/Favorites', methods=['GET'])
def get_favorites():
    sql = f"""SELECT * FROM Favorites;"""

    favorites = execute(sql)
    return jsonify(favorites)

@app.route('/Favorites', methods=['POST'])
def add_to_favorites():
    data = request.json
    
    id = data.get('id')
    score = data.get('score')
    question_id = data.get('question_id')
    title = data.get('title')
    description = data.get('description')
    content = data.get('content')
    url = data.get('url')
    urlToImage = data.get('urlToImage')
    publishedAt = data.get('publishedAt')
    api_source = data.get('api_source')
    
    # Validate required fields
    if not all([score, id, question_id, title, description, content, urlToImage, publishedAt, api_source]):
        return jsonify({"error": "Missing required fields"}), 400
    
    # Use parameterized query to prevent SQL injection
    sql = """INSERT INTO Favorites (score, id, question_id, title, description, content, url, urlToImage, publishedAt, api_source) 
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"""
    try:
        execute(sql, isSelect=False, params=(score, id, question_id, title, description, content, url, urlToImage, publishedAt, api_source))
        return jsonify({"message": "Item added to favorites successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/Favorites/<id>', methods=['DELETE'])
def delete_favorites_by_id(id):

    sql = f"DELETE FROM Favorites WHERE id = '{id}';"
    
    try:
        execute(sql, isSelect=False)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        app.logger.error(f"Error deleting item: {e}")
        return jsonify({"error": "Failed to delete item"}), 500

@app.route('/Topics', methods=['GET'])
def get_topics():
    sql = f"""SELECT * FROM Topics;"""

    users = execute(sql)
    return jsonify(users)

@app.route('/Questions', methods=['GET'])
def get_questions():
    sql = f"""SELECT * FROM Questions;"""

    users = execute(sql)
    return jsonify(users)

@app.route('/Articles', methods=['GET'])
def get_articles():
    sql = f"""SELECT * FROM Articles;"""

    users = execute(sql)
    return jsonify(users)

@app.route('/Videos', methods=['GET'])
def get_videos():
    sql = f"""SELECT * FROM Videos;"""

    users = execute(sql)
    return jsonify(users)

@app.route('/Articles/<question_id>', methods=['GET'])
def get_articles_by_qst(question_id):
    sql = f"""SELECT * FROM Articles WHERE question_id = '{question_id}';"""

    users = execute(sql)
    return jsonify(users)

@app.route('/Articles/<id>', methods=['DELETE'])
def delete_articles_by_id(id):

    sql = f"DELETE FROM Articles WHERE id = '{id}';"
    
    try:
        execute(sql, isSelect=False)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        app.logger.error(f"Error deleting item: {e}")
        return jsonify({"error": "Failed to delete item"}), 500

# Add a generic error handler
@app.errorhandler(Exception)
def handle_exception(e):
    app.logger.error(f"Unhandled exception: {e}")
    return jsonify({"error": "An unexpected error occurred"}), 500

if __name__ == '__main__':
    app.run(port=5000, debug=True, threaded=False)