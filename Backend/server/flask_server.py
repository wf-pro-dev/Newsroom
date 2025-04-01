from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

from app import create_app
from config.constants import DEBUG

app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000, debug=DEBUG, threaded=False)
