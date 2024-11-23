from flask import Flask, jsonify
from flask_cors import CORS

from routes.articles import articles_bp
from routes.videos import videos_bp
from routes.topics import topics_bp
from routes.questions import questions_bp

def create_app():
    app = Flask(__name__)
    
    # Configure CORS
    CORS(app, resources={
        r"/*": {
            "origins": "http://localhost:3000",
            "methods": ["GET", "POST", "DELETE", "OPTIONS"]
        }
    })
    
    # Register blueprints
    app.register_blueprint(articles_bp)
    app.register_blueprint(videos_bp)
    app.register_blueprint(topics_bp)
    app.register_blueprint(questions_bp)
       
    # Error handlers
    @app.errorhandler(Exception)
    def handle_exception(e):
        app.logger.error(f"Unhandled exception: {e}")
        return jsonify({"error": "An unexpected error occurred"}), 500

    @app.route('/favicon.ico')
    def favicon():
        return '', 204
        
    return app