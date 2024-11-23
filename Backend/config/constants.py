import os

COLUMNS = {
        "Fav_Articles": [
            "score",
            "question_id",
            "title",
            "description",
            "content",
            "url",
            "urlToImage",
            "publishedAt",
            "api_source",
            "obj_id"
        ],
        
       
        "Topics": [
            "title_top",
            "role_top"
        ],
        
        "Questions": [
            "question",
            "topic",
            "role",
            "keywords",
        ],
        
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
        
         "Fav_Videos" : [
            "question_id",
            "video_id",
            "description",
            "thumbnail",
            "orientation",
            "obj_id"
        ],
        
        "Videos": [
            "question_id",
            "video_id",
            "description",
            "thumbnail",
            "orientation"
        ],
        
         
        
    }


NEWSAPI_KEY=os.environ.get("NEWSAPI")
NEWSDATA_KEY=os.environ.get("NEWSDATA")