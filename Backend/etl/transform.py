from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from typing import Tuple, List, Dict
from rake_nltk import Rake
from server.models.db_article import articles
from server.models.db_video import videos
from core.services.article_analyzer import analyze_article_relevance
from etl.extract import fetch_articles


def generate_query(title_top: str, title_qst: str) -> Tuple[str, Dict[str, List[str]]]:
    """Generate a query string and a dictionary of queries for different APIs."""
    rake = Rake(max_length=3)
    rake.extract_keywords_from_text(title_qst)
    ranked_phrases = rake.get_ranked_phrases()
    top_keywords = ranked_phrases[:5]
    

    return ", ".join(top_keywords), {
        "NewsAPI": f"{title_top} {'AND' if top_keywords else ''} {' OR '.join(top_keywords)}",
        "NewsDATA": f"{title_top} {'AND' if top_keywords else ''} {' OR '.join(top_keywords)}",
        "YTAPI": f"{title_top} {'|' if top_keywords else ''} {' | '.join(top_keywords)}",
    }


from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.lsa import LsaSummarizer
from nltk.corpus import stopwords
import nltk

nltk.download('stopwords', quiet=True)
nltk.download('punkt', quiet=True)

def extract_top_keywords(text, language='english', num_keywords=5):
    """
    Extract top keywords from a given text
    
    Args:
        text (str): Input text to extract keywords from
        language (str): Language of the text
        num_keywords (int): Number of keywords to extract
    
    Returns:
        list: Top keywords
    """
    # Create a parser
    parser = PlaintextParser.from_string(text, Tokenizer(language))
    
    # Initialize the LSA summarizer
    summarizer = LsaSummarizer()
    
    # Get stop words
    stop_words = set(stopwords.words('english'))
    
    # Extract summary sentences
    summary_sentences = summarizer(parser.document, num_keywords)
    
    # Extract and filter keywords
    keywords = []
    for sentence in summary_sentences:
        words = str(sentence).lower().split()
        # Filter out stop words and non-alphabetic words
        filtered_words = [word for word in words if word.isalpha() and word not in stop_words]
        keywords.extend(filtered_words)
    
    # Remove duplicates and return top keywords
    return list(dict.fromkeys(keywords))[:num_keywords]



def newsapi_to_articles(api_article: dict) -> articles:
    """Transform a NewsAPI article object to an Article model instance."""
    return articles(
        api_source="NewsAPI",
        title=api_article["title"],
        description=api_article["description"],
        content=api_article["content"],
        url=api_article["url"],
        urlToImage=api_article["urlToImage"],
        publishedAt=api_article["publishedAt"],
    )


def newsdata_to_articles(api_article: dict) -> articles:
    """Transform a NewsDATA article object to an Article model instance."""
    return articles(
        api_source="NewsDATA",
        title=api_article["title"],
        description=api_article["description"],
        content=api_article["content"],
        url=api_article["link"],
        urlToImage=api_article["image_url"],
        publishedAt=api_article["pubDate"],
    )


def generate_articles(articles_by_api: Dict[str, List[dict]]) -> List[articles]:
    """Generate a list of Article model instances from API data."""
    res_articles = []
    for api_name, api_list in articles_by_api.items():
        for api_article in api_list:
            if api_name == "NewsAPI":
                res_articles.append(newsapi_to_articles(api_article))
            elif api_name == "NewsDATA":
                res_articles.append(newsdata_to_articles(api_article))
    return res_articles


def get_relevant_articles(list_article: List[articles], question: str) -> List[articles]:
    """Filter and sort articles based on their relevance to a question."""

    def articles_filter(article: articles) -> bool:
        article_to_dict = article.to_dict()
        
        description = (
            article_to_dict["description"]
            and article_to_dict["description"] != "[Removed]"
            and article_to_dict["urlToImage"] is not None
        )
        
        return description and article_to_dict["title"] != "[Removed]"

    filtered_articles = list(filter(articles_filter, list_article))
    
    for article in filtered_articles:
        article_to_dict = article.to_dict()
        description = article_to_dict["content"]
        if article_to_dict["api_source"] == "NewsDATA":
            description = article_to_dict["description"]
        article.score = analyze_article_relevance(
            question=question, article_description=description
        )

    relevant_articles = sorted(
        filtered_articles, key=lambda article: article.score, reverse=True
    )
    
    return relevant_articles[:20]


def generate_videos(videos_api: List[dict]) -> List[videos]:
    """Generate a list of Video model instances from API data."""
    video_objects = []
    for video in videos_api:
        if video["id"] and "videoId" in video["id"] and video["snippet"]["description"]:
            video_objects.append(
                videos(
                    video_id=video["id"]["videoId"],
                    description=video["snippet"]["description"],
                    thumbnail=video["snippet"]["thumbnails"]["high"]["url"],
                )
            )
    return video_objects


if __name__ == "__main__":
    question = "How do cryptocurrency market dynamics compare to traditional asset classes in terms of volatility and risk assessment?"
    
    print(generate_query(title_top="Climate change",title_qst=question)[0])
    print(extract_top_keywords(text=question))