
class Videos:
    
    
    def __init__(self, video_id, description ) -> None :
        self.__question_id = 0
        self.__video_id = video_id
        self.__description = description   
        
    
    def set_question_id(self,question_id:int): self.__question_id = question_id
    
    def to_dict(self): 
        return {
            "question_id": self.__question_id,
            "video_id": self.__video_id,
            "description" : self.__description
        }