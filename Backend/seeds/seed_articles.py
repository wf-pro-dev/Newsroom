from sys import path
import os
current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.models.db_article import articles
from database.connection import db
from etl.transform import get_relevant_articles

def seed_articles(articles:list[articles],question):
    

    relevant_articles = get_relevant_articles(
        articles, question=question.text
    )

    for article in relevant_articles:
        article.question_id = question.id

        db.session.add(article)
        db.session.commit()

        print(
            f"Artilce with id = {article.id} is complete",
            "-" * 20,
            sep="\n",
        )

        
