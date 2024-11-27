from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

# etl import
from etl.extract import fetch_Questions

# core import
from core.models.question import Question


class Topics:

    def __init__(self, title_top: str, role_top: str):

        self.__title_top = title_top
        self.__role_top = role_top
        self.__questions = self.set_questions()

    def get_title_top(self):
        return self.__title_top

    def get_questions(self):
        return self.__questions

    def set_questions(self):
        str_questions = fetch_Questions(topic=self.__title_top, role=self.__role_top)
        return [
            Question(question, (self.__title_top, self.__role_top))
            for question in str_questions
        ]

    def to_dict(self):
        return {
            "title_top": self.__title_top,
            "role_top": self.__role_top,
            "questions": [question.to_dict() for question in self.__questions],
        }
