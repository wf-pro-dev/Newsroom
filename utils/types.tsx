type Video = {
  id:number,
  question_id:string,
  video_id:string,
  description:string,
  thumbnail:string,
  orientation:string

  obj_id?:number;
}

type Article = {
  id: number;
  question_id: string;
  title: string;
  description: string;
  publishedAt:string;
  source:string
  url:string;
  urlToImage: string;
  api_sourec: string;

  obj_id?:number;
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



export type { Article, Question, Topic, Video };
