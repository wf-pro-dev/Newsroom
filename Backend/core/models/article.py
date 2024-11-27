class Article:

    def __init__(self, obj_art: dict) -> None:

        self.__score = 0
        self.__question_id = 0
        
        self.__title = obj_art["title"]
        self.__description = obj_art["description"]
        self.__content = obj_art["content"]
        self.__url = obj_art["url"]
        self.__urlToImage = obj_art["urlToImage"]
        self.__publishedAt = obj_art["publishedAt"]
        self.__api_source = obj_art["api_source"]

    def set_score(self, score: float) -> float:
        self.__score = score

    def get_score(self) -> float:
        return self.__score

    def set_question_id(self, question_id: int):
        self.__question_id = question_id

    def get_title(self):
        return self.__title

    def get_description(self) -> str:
        return self.__description

    def get__urlToImage(self) -> str:
        return self.__urlToImage

    def get_api_source(self) -> str:
        return self.__api_source

    def to_dict(self):
        return {
            "score": self.__score,
            "question_id": self.__question_id,
            "title": self.__title,
            "description": self.__description,
            "content": self.__content,
            "url": self.__url,
            "urlToImage": self.__urlToImage,
            "publishedAt": self.__publishedAt,
            "api_source": self.__api_source,
        }


if __name__ == "__main__":
    obj_art = {
        "score": 1,
        "title": "Allez le Foot",
        "url": "url",
        "img_url": "img",
        "pubDate": "today",
        "api_source": "NewsAPI",
    }
    art = Article(id=0, qst_id=0, topics_id=0, obj_art=obj_art)
    print(vars(art))
