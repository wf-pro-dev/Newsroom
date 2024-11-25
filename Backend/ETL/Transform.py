from sys import path
path.append('/Users/williamfotso/Workspace/Newsroom/Backend')

from typing import Tuple
from rake_nltk import Rake

from core.models.article import Article
from core.services.article_analyzer import analyze_article_relevance

from core.models.video import Videos


def generate_Query(title_top: str, title_qst: str) -> Tuple[str, dict[str, list]]:
    # Natural Language Processing
    # get five most important keywords from question

    # Initialize RAKE with English stopwords
    rake = Rake(max_length=3)

    # Extract keywords from the title question
    rake.extract_keywords_from_text(title_qst)

    # Get the ranked phrases with their scores
    ranked_phrases = rake.get_ranked_phrases()

    # Extract the top 5 keywords/phrases
    top_keywords = ranked_phrases[:5]


    return ', '.join(top_keywords), {
        "NewsAPI": f"{title_top} {'AND' if len(top_keywords) > 0 else '' } {' OR '.join(top_keywords)}",
        "NewsDATA":  f"{title_top} {'AND' if len(top_keywords) > 0 else '' } {' OR '.join(top_keywords)}",
        "YTAPI" : f"{title_top} {'|' if len(top_keywords) > 0 else '' } {' | '.join(top_keywords)}"
    }
    

def NewsAPI_to_Articles(api_article:dict) -> Article:
    # Transform NewsAPI object to Artcile object

    obj_art = {
        "api_source": "NewsAPI",
        "title": api_article["title"],
        "description": api_article["description"],
        "content": api_article["content"],
        "url": api_article["url"],
        "urlToImage": api_article["urlToImage"],
        "publishedAt": api_article["publishedAt"]      
    }
    
    res_artcile = Article(obj_art=obj_art)
    return res_artcile

def NewsDATA_to_Articles(api_article:dict) -> Article:
    # Transform NewsDATA object to Artcile object
    
    
    
    obj_art = {
        "api_source": "NewsDATA",
        "title": api_article['title'],
        "description": api_article['description'],
        "content": api_article['content'],
        "url": api_article['link'],
        "urlToImage": api_article['image_url'],
        "publishedAt": api_article['pubDate']
    }
    
    res_artcile = Article(obj_art=obj_art)
    return res_artcile

def generate_Articles(articles_by_api: dict[str,list]) -> list[Article]:
    # Takes in articles_by_api returns list of 20 Article
    
    res_articles = []
    
    for api_name, api_list in articles_by_api.items():
        for api_article in api_list:
            
            if api_name == "NewsAPI":
                res_articles.append(NewsAPI_to_Articles(api_article))
            elif api_name == "NewsDATA":
                res_articles.append(NewsDATA_to_Articles(api_article))
                     
    return res_articles

def get_relevant_articles(articles:list[Article],question:str) -> list[Article] :
    
    def articles_filter(article:Article):
        article_to_dict = article.to_dict()
        description = article_to_dict["description"] and article_to_dict["description"] != None and article_to_dict["description"] != "[Removed]"
        return description and article_to_dict["title"] != "[Removed]" and article_to_dict["urlToImage"] != None
    
    articles = list(filter(lambda article : articles_filter(article),  articles))  
    
    for article in articles:
        article_to_dict = article.to_dict()
        description = article_to_dict["content"] if article_to_dict["api_source"] == "NewsAPI" else article_to_dict["description"]
        article.set_score(analyze_article_relevance(question=question,article_description=description))
    
    set_of_articles = set(articles)
    relevant_articles = sorted(set_of_articles,key=lambda article : article.get_score() ,reverse=True)
                
    return relevant_articles[:20]

def generate_Videos(videos_api:list) -> list:

    
    videos = []
    
    for video in videos_api:
        
        if video["id"] and "videoId" in video["id"].keys() and video["snippet"]["description"]:
            videos.append(Videos(video["id"]["videoId"],video["snippet"]["description"],video["snippet"]["thumbnails"]))
    
    return videos


if __name__ == "__main__":
    pass
        