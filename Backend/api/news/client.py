from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from api.news.newsapi import NewsAPI
from api.news.newsdata import NewsDATA


class Newsfetcher:
    """
    Manages fetching news articles from multiple news API sources.
    """
    def __init__(self):
        self.__apis = [NewsAPI(),NewsDATA()]

    def fetch_articles(self,query:str) -> dict[str,list]:
        """
        Fetch news articles from multiple news API sources.
        
        Parameters:
        
        Returns:
        Dict: Dict of (Api, Article[])
        """
        articles_by_api = dict[str,list]()
        
        for api in self.__apis:
            articles_by_api[api.__class__.__name__] = api.fetch_articles(query=query[api.__class__.__name__])
            
        return articles_by_api

if __name__ == "__main__":
    pass