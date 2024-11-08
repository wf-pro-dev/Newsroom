from API.Newsfetcher import Newsfetcher
from API.Open_AI import fetch_open_AI

def fetch_Topics() -> list[dict[str, str]]:
    """
    Fetches a list of topics related to current news along with the best suited role to educate about those topics.
    
    Parameters:
    None
    
    Returns:
    list[dict[str, str]]: A list of JSON objects, each containing a topic and a role.
    """
    
    prompt ="""
            Create a list of 5 elements of JSON schema with the following structure:
            {
                "topic": "Find a topic related to current news. Write it in 1 or 2 words",
                "role": "Find the best suited role to educate about the topics"
            }
            Make the response as concise as possible. Include only the list
            """
   
    return fetch_open_AI(prompt=prompt)

def fetch_Questions(topic:str,role:str) -> list[str]:
    """
    Generates insightful questions about a given topic from the perspective of a specified role.
    
    Parameters:
    topic (str): The topic to generate questions about.
    role (str): The role from whose perspective the questions are generated.
    
    Returns:
    list[str]: A list of questions related to the topic from the role's perspective.
    """
    
    N_QST_PER_TOP = 3
    
    prompt = f"""
        Generate {N_QST_PER_TOP} insightful questions about {topic} from the perspective of a {role}.
        The questions should:
        1. Be specific to how a {role} would approach or think about {topic}
        2. Reflect the professional concerns and interests of a {role}
        3. Be concise. Keep the question to 50 characters or less
        
        Format: Return a a JSON schema of a python list with the question as element
        """
   
    return fetch_open_AI(prompt=prompt)

def fetch_Articles(query:str) -> dict[str,list]:
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


if __name__ == "__main__":
    topic = fetch_Topics()[0]
    print(fetch_Questions(topic=topic["topic"],role=topic["role"]))


