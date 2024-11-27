from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from typing import Tuple
from rake_nltk import Rake


from Server.models.db_article import articles
from Server.models.db_video import videos
from core.services.article_analyzer import analyze_article_relevance



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

    return ", ".join(top_keywords), {
        "NewsAPI": f"{title_top} {'AND' if len(top_keywords) > 0 else '' } {' OR '.join(top_keywords)}",
        "NewsDATA": f"{title_top} {'AND' if len(top_keywords) > 0 else '' } {' OR '.join(top_keywords)}",
        "YTAPI": f"{title_top} {'|' if len(top_keywords) > 0 else '' } {' | '.join(top_keywords)}",
    }


def NewsAPI_to_Articles(api_article: dict) -> articles:
    # Transform NewsAPI object to Artcile object

    res_article = articles(
        api_source="NewsAPI",
        title=api_article["title"],
        description=api_article["description"],
        content=api_article["content"],
        url=api_article["url"],
        urlToImage=api_article["urlToImage"],
        publishedAt=api_article["publishedAt"],
    )
 
    return res_article


def NewsDATA_to_Articles(api_article: dict) -> articles:
    # Transform NewsDATA object to Artcile object

    res_article = articles(
        api_source="NewsDATA",
        title=api_article["title"],
        description=api_article["description"],
        content=api_article["content"],
        url=api_article["link"],
        urlToImage=api_article["image_url"],
        publishedAt=api_article["pubDate"],
    )
 
    return res_article


def generate_Articles(articles_by_api: dict[str, list]) -> list[articles]:
    # Takes in articles_by_api returns list of 20 Article

    res_articles = []

    for api_name, api_list in articles_by_api.items():
        for api_article in api_list:

            if api_name == "NewsAPI":
                res_articles.append(NewsAPI_to_Articles(api_article))
            elif api_name == "NewsDATA":
                res_articles.append(NewsDATA_to_Articles(api_article))

    return res_articles


def get_relevant_articles(articles: list[articles], question: str) -> list[articles]:

    def articles_filter(article: articles):
        article_to_dict = article.to_dict()
        description = (
            article_to_dict["description"]
            and article_to_dict["description"] != None
            and article_to_dict["description"] != "[Removed]"
        )
        return (
            description
            and article_to_dict["title"] != "[Removed]"
            and article_to_dict["urlToImage"] != None
        )

    articles = list(filter(lambda article: articles_filter(article), articles))

    for article in articles:
        article_to_dict = article.to_dict()
        
        description = article_to_dict["content"] 
        if article_to_dict["api_source"] == "NewsDATA":
            description = article_to_dict["description"]
        
        article.score = (
            analyze_article_relevance(
                question=question, article_description=description
            )
        )

    set_of_articles = set(articles)
    relevant_articles = sorted(
        set_of_articles, key=lambda article: article.score, reverse=True
    )

    return relevant_articles[:20]

def generate_Videos(videos_api: list) -> list[videos]:  # Assuming videos is the model class
    video_objects = []

    for video in videos_api:
        if (
            video["id"]
            and "videoId" in video["id"].keys()
            and video["snippet"]["description"]
        ):
            video_objects.append(
                videos(
                    video_id=video["id"]["videoId"],
                    description=video["snippet"]["description"],
                    thumbnail=video["snippet"]["thumbnails"]["high"]["url"],
                )
            )
    return video_objects


if __name__ == "__main__":
    pass
