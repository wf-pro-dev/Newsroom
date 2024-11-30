from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# config
from config.constants import NEWSAPI_KEY

from newsapi import NewsApiClient


class NewsAPI:
    """
    Handles fetching news articles from NewsAPI.
    """

    def __init__(self):
        pass

    def fetch_articles(self, query: str) -> list:
        """
        Fetch news articles from the configured news API source.

        Parameters:
        params str: query passed to the API

        Returns:
        list: List of API Native article obj
        """
        try:

            newsapi = NewsApiClient(api_key=NEWSAPI_KEY)
            NewsAPI_articles = newsapi.get_everything(q=query, page_size=30)
            return NewsAPI_articles["articles"]

        except Exception as e:
            print(f"Error fetching articles from {self.__class__.__name__}: {e}")
            return []
