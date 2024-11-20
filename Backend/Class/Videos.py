from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

class Videos:
    
    
    def __init__(self, video_id, description,thumbnails ) -> None :
        self.__question_id = 0
        self.__video_id = video_id
        self.__description = description
        self.__thumbnail, self.__orientation = self.set_orientation(thumbnails)
        
    
    def set_question_id(self,question_id:int) -> int: self.__question_id = question_id
    
    def set_orientation(self,thumbnails:dict) -> tuple:
        i = 1
        len_thumbnails = len(list(thumbnails.values()))
        thumbnail = list(thumbnails.values())[len_thumbnails - i]
        
        while i <= len(list(thumbnails.values())) and not thumbnail:
            i+=1
            thumbnail = list(thumbnails.values())[len_thumbnails - i]
            
        orientation = "landscape" if thumbnail["width"] / thumbnail["height"] > 1 else "portrait"
            
        return thumbnail["url"], orientation

    def get__thumbnail(self) -> str: return self.__thumbnail
    def get_orientation(self) -> str: return self.__orientation
    
    def to_dict(self): 
        return {
            "question_id": self.__question_id,
            "video_id": self.__video_id,
            "description" : self.__description,
            "thumbnail" : self.__thumbnail,
            "orientation": self.__orientation
        }

# if __name__ == "__main__":
#     for video in generate_Videos(fetch_video("Technology")):
#         print(video.get__thumbnail())
#         print(video.get_orientation())
        