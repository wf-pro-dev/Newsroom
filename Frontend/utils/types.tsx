type User = {
  username: string;
  email: string;
  image?: string;
}

type Topic = {
  id: number;
  title: string;
  role: string;
  images:string[];
};

type Question = {
  id: number;
  keywords: string;
  text: string;
  topic_id: number; // Changed from topic to topic_id to match the model
  order:number
};

interface newQuestion extends Question {
  articles: Article[];
  videos: Video[];
}

type Video = {
  id: number;
  question_id: number;
  youtube_id: string; // Changed from number to string
  description: string;
  thumbnail: string;
  type : "video"

};

type Article = {
  id: number;
  question_id: number;
  title: string;
  description: string;
  content: string;
  publishedAt: string; // Ensure this is a string if you're using ISO format
  url: string;
  urlToImage: string;
  api_source: string;
  score: number;
  type : "article";
};


type Favourite =
  | (Article & { article_id: number; favAt: string; user_id: number })
  | (Video & { video_id: number; favAt: string; user_id: number });

type Collection = {
  id: number;
  name: string;
  user_id: number;
  createdAt: string;
  items: Item[];
}

type Item = {
  id: number;
  pos_x: number;
  pos_y: number;
  collection_id: number;
  content: Article | Video;
  content_id: number;
  content_type: string;
  createdAt: string;
}

type Page = "Login" | "Header" | "Topic" | "Question" | "Profile" | "Collection" | "Canvas"


export type { User, Article, Question, newQuestion, Topic, Video, Favourite, Collection, Item, Page };
