import os

YT_KEY=os.environ.get("YT_KEY")

import googleapiclient.discovery
import googleapiclient.errors

scopes = ["https://www.googleapis.com/auth/youtube.force-ssl"]

def fetch_video(query:str) -> list[dict]:
    # Disable OAuthlib's HTTPS verification when running locally.
    # *DO NOT* leave this option enabled in production.
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"

    api_service_name = "youtube"
    api_version = "v3"

    # Create an API client using the API key
    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, developerKey=YT_KEY)

    request = youtube.search().list(
        part="id,snippet",
        q=query
    )
    response = request.execute()
    return response["items"]



if __name__ == "__main__":
    query = "Cybersecurity | prioritize threats based | potential impact | defense strategy | exploitability"
    print(fetch_video(query))