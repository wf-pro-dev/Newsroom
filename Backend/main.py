
# core import
from core.models.topic import Topics


# ETL import
from etl.extract import fetch_Topics
from etl.transform import get_relevant_articles

from database.operations import init, insert_data, show_table, COLUMNS




    
def main():

    init()
    
    for obj_topic in fetch_Topics():
        
        topic = Topics(obj_topic["topic"],obj_topic["role"])
        
        topic_id = insert_data(table_name="Topics",obj=topic)
        
        
        questions = topic.get_questions()
        for question in questions:
            
            questtion_id = insert_data(table_name="Questions",obj=question)    
            
            relevant_artciles = get_relevant_articles(question.get_articles(),question=question.get_question())
            
            unique_articles = list(set(relevant_artciles))

            for article in unique_articles:
                
                article.set_question_id(question_id=questtion_id)
                
                article_id = insert_data(table_name="Articles",obj=article)
                print(f"Artilce with id = {article_id} is complete","-" * 20,sep="\n")
            
            videos = question.get_videos()
            
            for video in videos:
                video.set_question_id(question_id=questtion_id)
                video_id = insert_data(table_name="Videos",obj=video)
                print(f"Video with id = {video_id} is complete","-" * 20,sep="\n")
            
            print(f"Question with id = {questtion_id} is complete","-" * 20,sep="\n")
        
        print(f"Topic with id = {topic_id} is complete","-" * 20,sep="\n")
            
    
    show_table(table_name="Topics")
    
    

if __name__ == "__main__":
    
    main()
    print("Database Complete !")
    # for question in Topic.get_questions():
    #     print(question)
