
type Article = {
  id: number;
  question_id: string;
  title: string;
  description: string;
  publishedAt:string;
  source:string
  url:string;
  urlToImage: string;
  fav_id?: string;
};


type Question = {
  id: number;
  keywords: string;
  question: string;
  topic: string;
};

type Topic = {
  id: number;
  title_top: string;
  role_top: string;

};



export type { Article, Question, Topic };
