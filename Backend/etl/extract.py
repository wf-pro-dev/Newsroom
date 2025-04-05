from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from api.news.client import Newsfetcher
from api.openai.client import fetch_open_ai
from api.genai.client import fetch_gen_ai
from api.youtube.client import fetch_video


def fetch_topics(n_elem:int) -> list[dict[str, str]]:
    """
    Fetches a list of topics related to current news along with the best suited role to educate about those topics.

    Parameters:
    None

    Returns:
    list[dict[str, str]]: A list of JSON objects, each containing a topic and a role.
    """
    topics = []
    
    elem_str = f"Create a list of {n_elem} elements of JSON schema with the following structure:"
    prompt = """
            {
                "topic": "Find a topic related to current news. Write it in 1 or 2 words",
                "role": "Find the best suited role to educate about the topics"
            }
            Make the response as concise as possible. Include only the list
            """
    
    try:
        topics = fetch_open_ai(prompt=elem_str+prompt)
    except Exception as error:
        print("Error Fetching from OpenAI switch to GenAi",error)
        topics = fetch_gen_ai(prompt=elem_str+prompt)
        
    return topics


def fetch_questions(topic: str, role: str,n_qst:int=3) -> list[str]:
    """
    Generates questions about a given topic from the perspective of a specified role.

    Parameters:
    topic (str): The topic to generate questions about.
    role (str): The role from whose perspective the questions are generated.

    Returns:
    list[str]: A list of questions related to the topic from the role's perspective.
    """

    questions = []

    prompt = f"""
        Generate {n_qst} insightful questions about {topic} from the perspective of a {role} perspective.
        The questions should:
        1. Be specific to how a {role} would approach or think about {topic}
        2. Reflect the professional concerns and interests of a {role}
        3. Be comprehensible by a broad public (not well versed in {topic} )
        3. Be concise. Keep the question to 20 words or less
        
        Format: Return a a JSON schema of a python list with the question as element
        """
     
    try:
        questions = fetch_open_ai(prompt=prompt)
    except Exception as error:
        print("Error Fetching from OpenAI switch to GenAi",error)
        questions = fetch_gen_ai(prompt=prompt)

    return questions


def fetch_articles(query: dict) -> dict[str, list]:
    """
    Fetches news articles from multiple news API sources based on a given query.

    Parameters:
    query (str): The query to search for articles.

    Returns:
    dict[str,list]: A dictionary where the keys are the names of the news API sources and the values are lists of articles.
    """
    fetcher = Newsfetcher()
    articles_by_api = fetcher.fetch_articles(query=query)

    return articles_by_api


def fetch_videos(query: dict) -> list:

    videos = fetch_video(query=query["YTAPI"])
    return videos


if __name__ == "__main__":
    query = {"NewsAPI" : "Tech","NewsDATA": "Tech" }
    print(fetch_articles(query=query))
