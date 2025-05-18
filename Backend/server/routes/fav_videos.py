from sys import path
import os
from flask import Blueprint, jsonify, request, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.models.db_fav_videos import fav_videos
from Backend.server.models.db_videos import videos

fav_videos_bp= Blueprint("fav_videos", __name__)


@fav_videos_bp.route("/favorites/videos", methods=["GET"])
@jwt_required()
def get_fav_videos():
    
    # Get the current user's ID from the JWT token
    current_user_id = get_jwt_identity() 

    videos = fav_videos.query.filter_by(user_id=current_user_id).all()

    return jsonify([video.to_dict() for video in videos])

@fav_videos_bp.route('/favorites/add/video', methods=['POST'])
@jwt_required()
def add_fav_video():
    """
    Add an article to the user's favorites
    
    POST data:
    - article_id: ID of the article to favorite
    - notes: Optional notes about the favorited article
    
    Returns:
    - JSON with the created favorite article
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Get the request data
        data = request.get_json()
        
        if not data or 'video_id' not in data  :
            return jsonify({'error': 'Video ID is required'}), 400
        
        video_id = data['video_id']
        
        # Check if the article exists
        video = videos.query.get(video_id)
        if not video:
            return jsonify({'error': 'Video not found'}), 404

        # Check if the video is already favorited by this user
        existing_favorite = fav_videos.query.filter_by(
            video_id=video_id,
            user_id=current_user_id
        ).first()
        
        if existing_favorite:
            return jsonify({'error': 'Video already in favorites'}), 409
        
        # Create a new favorite article
        new_favorite = fav_videos(
            user_id=current_user_id,
            # Copy all data from the original video
            question_id = video.question_id,
            youtube_id = video.youtube_id,
            video_id = video.id,
            description = video.description,
            thumbnail = video.thumbnail 
        )
        
        # Add to database and commit
        db.session.add(new_favorite)
        db.session.commit()
        
        # Return the favorite article as JSON
        return jsonify({
            'message': 'Video added to favorites successfully',
            'favorite': new_favorite.to_dict()
        }), 201
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error adding favorite: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500



@fav_videos_bp.route("/favorites/delete/video/<int:id>", methods=["DELETE"])
def delete_video_by_id(id):
    try:
        fav_video = fav_videos.query.filter_by(id=id).one_or_none()
        if fav_video:
            db.session.delete(fav_video)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

