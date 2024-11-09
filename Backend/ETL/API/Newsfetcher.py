import os
from newsapi import NewsApiClient
from newsdataapi import NewsDataApiClient

NEWSAPI_KEY=os.environ.get("NEWSAPI")
NEWSDATA_KEY=os.environ.get("NEWSDATA")

class NewsAPI:
    """
    Handles fetching news articles from NewsAPI.
    """
    def __init__(self):
        pass

    def fetch_articles(self,query:str) -> list:
        """
        Fetch news articles from the configured news API source.
        
        Parameters:
        params str: query passed to the API
        
        Returns:
        list: List of API Native article obj
        """
        try:
            
            newsapi = NewsApiClient(api_key=NEWSAPI_KEY)
            NewsAPI_articles = newsapi.get_everything(q=query,page_size=30)
            return NewsAPI_articles['articles']
        
        except Exception as e:
            print(f"Error fetching articles from {self.__class__.__name__}: {e}")
            return []

class NewsDATA:
    """
    Handles fetching news articles from NewsDATA.
    """
    def __init__(self):
        pass

    def fetch_articles(self,query:str) -> list:
        """
        Fetch news articles from the configured news API source.
        
        Parameters:
        params str: query passed to the API
        
        Returns:
        list: List of API Native article obj
        """
        try:
            
            api = NewsDataApiClient(apikey=NEWSDATA_KEY)
            NewsDATA_articles = api.news_api( q=query )
            return NewsDATA_articles["results"]
        
        except Exception as e:
            print(f"Error fetching articles from {self.__class__.__name__}: {e}")
            return []

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