from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# Config
from config.constants import NEWSDATA_KEY

from newsdataapi import NewsDataApiClient


class NewsDATA:
    """
    Handles fetching news articles from NewsDATA.
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

            api = NewsDataApiClient(apikey=NEWSDATA_KEY)
            NewsDATA_articles = api.news_api(q=query)
            return NewsDATA_articles["results"]

        except Exception as e:
            print(f"Error fetching articles from {self.__class__.__name__}: {e}")
            return []
