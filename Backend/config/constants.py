import os

# /* TEST MODE */
TEST_MODE=os.environ.get("NEWSROOM_TESTMODE") == "1"

# /* APi Keys */
NEWSAPI_KEY=os.environ.get("NEWSAPI")
NEWSDATA_KEY=os.environ.get("NEWSDATA")

# /* Table and columns for .db file */
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
