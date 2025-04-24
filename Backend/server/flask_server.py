from sys import path
import os


# Add proper relative import paths
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.app import create_app
from config.constants import DEBUG

app = create_app()

if __name__ == "__main__":
    app.run(host="127.0.0.1",port=5000, debug=DEBUG, threaded=False)
