from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

from server.app import create_app
from config.constants import DEBUG

app = create_app()

if __name__ == "__main__":
    app.run(port=5000, debug=DEBUG, threaded=False)
