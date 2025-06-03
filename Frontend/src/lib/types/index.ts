type User = {
  username: string;
  email: string;
  image?: string;
}

type Topic = {
  id: number;
  title: string;
  role: string;
  images: string[];
};

type Question = {
  id: number;
  keywords: string;
  text: string;
  topic_id: number;
  order: number;
};

interface newQuestion extends Question {
  articles: Article[];
  videos: Video[];
}

type Video = {
  id: number;
  question_id: number;
  youtube_id: string;
  description: string;
  thumbnail: string;
  type: "video";
};

type Article = {
  id: number;
  question_id: number;
  title: string;
  description: string;
  content: string;
  publishedAt: string;
  url: string;
  urlToImage: string;
  api_source: string;
  score: number;
  type: "article";
};

type Favourite =
  | (Article & { article_id: number; favAt: string; user_id: number })
  | (Video & { video_id: number; favAt: string; user_id: number });

export type { 
  User, 
  Article, 
  Question, 
  newQuestion, 
  Topic, 
  Video, 
  Favourite 
}; 