"""
Main module for setting up the database and processing topics, questions, articles, and videos.
"""

# Database import
from database.connection import db

# server import
from server.app import create_app
from server.models.db_topic import topics

# ETL imports
from etl.extract import fetch_Topics
from etl.transform import get_relevant_articles, generate_Query


def main():
    """Main function to initialize the app and process data."""
    app = create_app()

    with app.app_context():
        # Drop all tables
        db.drop_all()

        # Recreate all tables
        db.create_all()
        for obj_topic in fetch_Topics():
            
            topic = topics(title=obj_topic["topic"], role=obj_topic["role"])
            db.session.add(topic)
            db.session.commit()

            questions = topic.set_questions()

            for question in questions:
                question.topic_id = topic.id

                keywords, query = generate_Query(
                    (topic.title, topic.role), question.text
                )

                question.keywords = keywords

                db.session.add(question)
                db.session.commit()

                relevant_artciles = get_relevant_articles(
                    question.set_articles(query=query), question=question.text
                )

                for article in relevant_artciles:
                    article.question_id = question.id

                    db.session.add(article)
                    db.session.commit()

                    print(
                        f"Artilce with id = {article.id} is complete",
                        "-" * 20,
                        sep="\n",
                    )

                videos = question.set_videos(query=query)

                for video in videos:
                    video.question_id = question.id

                    db.session.add(video)
                    db.session.commit()

                    print(f"Video with id = {video.id} is complete", "-" * 20, sep="\n")

                print(
                    f"Question with id = {question.id} is complete", "-" * 20, sep="\n"
                )

            print(f"Topic with id = {topic.id} is complete", "-" * 20, sep="\n")


if __name__ == "__main__":
    main()
    print("Database Complete !")
    # for question in Topic.get_questions():
    #     print(question)
