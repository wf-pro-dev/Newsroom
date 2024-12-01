from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, '../../'))
backend_root = project_root + "/Backend"
path.append(backend_root)

from Api.news.newsapi import NewsAPI
from Api.news.newsdata import NewsDATA


class Newsfetcher:
    """
    Manages fetching news articles from multiple news API sources.
    """

    def __init__(self):
        self.__apis = [NewsAPI(), NewsDATA()]

    def fetch_articles(self, query: dict) -> dict[str, list]:
        """
        Fetch news articles from multiple news API sources.

        Parameters:

        Returns:
        Dict: Dict of (Api, Article[])
        """
        articles_by_api = dict[str, list]()

        for api in self.__apis:
            articles_by_api[api.__class__.__name__] = api.fetch_articles(
                query=query[api.__class__.__name__]
            )

        return articles_by_api


if __name__ == "__main__":
    pass
