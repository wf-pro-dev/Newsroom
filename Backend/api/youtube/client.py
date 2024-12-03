from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

import os

import googleapiclient.discovery
import googleapiclient.errors

from config.constants import YOUTUBE_KEY

scopes = ["https://www.googleapis.com/auth/youtube.force-ssl"]


def fetch_video(query: str) -> list[dict]:
    # Disable OAuthlib's HTTPS verification when running locally.
    # *DO NOT* leave this option enabled in production.
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"

    api_service_name = "youtube"
    api_version = "v3"

    # Create an API client using the API key
    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, developerKey=YOUTUBE_KEY
    )

    request = youtube.search().list(part="id,snippet", q=query)
    response = request.execute()
    return response["items"]


if __name__ == "__main__":
    query = "Cybersecurity | prioritize threats based | potential impact | defense strategy | exploitability"
    print(fetch_video(query))
