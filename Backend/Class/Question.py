from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from typing import Tuple

from ETL.Extract import fetch_Articles
from ETL.Transform import generate_Query, generate_Articles

class Question:
    
    def __init__(self,question:str,top_and_role:Tuple[str,str]) -> None:
        
        self.__question = question
        self.__topic, self.__role = top_and_role
        self.__keywords, self.__query = generate_Query(top_and_role,question)
        self.__articles = self.set_articles()
    
    
    def set_articles(self) :
        raw_articles = fetch_Articles(self.__query)
        return generate_Articles(raw_articles)
    def get_articles(self): return self.__articles
    
    def to_dict(self):
        return {
            "question": self.__question,
            "topic": self.__topic,
            "role": self.__role,
            "keywords": self.__keywords,
            "query": self.__query,
            "articles": [article.to_dict() for article in self.__articles]
        }
    
    def __str__(self) -> str:
        
        len_API = len(list(filter(lambda article: article.get_api_source() == "NewsAPI",self.__articles)))
        len_DATA = len(list(filter(lambda article: article.get_api_source() == "NewsDATA",self.__articles)))
        qst_str = f"""
        {'-' * 10} {self.__question} {'-' * 10}
 
        Topic : {self.__topic} | Role : {self.__role}
        Keywords : {self.__keywords}
        Len of Articles : {len(self.__articles)} | Len of API : {len_API} | Len of DATA: {len_DATA}
        """
        
        return qst_str