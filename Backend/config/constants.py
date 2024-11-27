from dotenv import load_dotenv, find_dotenv
import os


NEWSROOM_PATH = "/Users/williamfotso/Workspace/Newsroom/Backend/"

env = os.getenv("FLASK_ENV", "development")

# Load env var for ANY MODE
load_dotenv()

# /* APi Keys */
NEWSAPI_KEY = os.getenv("NEWSAPI")
NEWSDATA_KEY = os.getenv("NEWSDATA")
YOUTUBE_KEY = os.getenv("YT_KEY")

# /* Lint Config */
LINT_PATH = os.getenv("LINT_PATH", NEWSROOM_PATH)
FORMAT_PATH = os.getenv("FORMAT_PATH", NEWSROOM_PATH)
PYLINT_RCFILE = os.getenv("PYLINT_RCFILE", "")
BLACK_LINE_LENGTH = os.getenv("BLACK_LINE_LENGTH", "88")

# Load env var for FLASK_ENV
load_dotenv(f"{NEWSROOM_PATH}/.env.{env}")
DEBUG = os.getenv("DEBUG", "True") == "True"
DATABASE_URI = os.getenv("DATABASE_URI")

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
        "obj_id",
    ],
    "Topics": ["title_top", "role_top"],
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
        "api_source",
    ],
    "Fav_Videos": [
        "question_id",
        "video_id",
        "description",
        "thumbnail",
        "orientation",
        "obj_id",
    ],
    "Videos": ["question_id", "video_id", "description", "thumbnail", "orientation"],
}
