import sqlite3, json

# Class import
from Class.Topics import Topics


# ETL import
from ETL.Extract import fetch_Topics
from ETL.Transform import get_relevant_articles
from ETL.Load import create_table, insert_data, delete_all_tables, show_table

# DB paths
main_db = '/Users/williamfotso/Workspace/Newsroom/Backend/DB_Files/main_db.db'
test_db = '/Users/williamfotso/Workspace/Newsroom/Backend/DB_Files/test_db.db'

def init(db_conn):
    delete_all_tables(db_conn=db_conn)
    create_table(db_conn=db_conn,table_name="Favorites")
    create_table(db_conn=db_conn,table_name="Topics")
    create_table(db_conn=db_conn,table_name="Questions")
    create_table(db_conn=db_conn,table_name="Articles")
    create_table(db_conn=db_conn,table_name="Videos")
    
def main():
    
    db_conn = sqlite3.connect(test_db) 
    init(db_conn=db_conn)
    
    for obj_topic in fetch_Topics():
        
        topic = Topics(obj_topic["topic"],obj_topic["role"])
        
        topic_id = insert_data(db_conn=db_conn,table_name="Topics",obj=topic)
        
        
        questions = topic.get_questions()
        for question in questions:
            
            questtion_id = insert_data(db_conn=db_conn,table_name="Questions",obj=question)    
            
            relevant_artciles = get_relevant_articles(question.get_articles(),question=question.get_question())
            
            unique_articles = list(set(relevant_artciles))

            for article in unique_articles:
                
                article.set_question_id(question_id=questtion_id)
                
                article_id = insert_data(db_conn=db_conn,table_name="Articles",obj=article)
                print(f"Artilce with id = {article_id} is complete","-" * 20,sep="\n")
            
            videos = question.get_videos()
            
            for video in videos:
                video.set_question_id(question_id=questtion_id)
                video_id = insert_data(db_conn=db_conn,table_name="Videos",obj=video)
                print(f"Video with id = {video_id} is complete","-" * 20,sep="\n")
            
            print(f"Question with id = {questtion_id} is complete","-" * 20,sep="\n")
        
        print(f"Topic with id = {topic_id} is complete","-" * 20,sep="\n")
            
    
    show_table(db_conn=db_conn,table_name="Topics")
    
    

if __name__ == "__main__":
    
    main()
    print("Database Complete !")
    # for question in Topic.get_questions():
    #     print(question)
