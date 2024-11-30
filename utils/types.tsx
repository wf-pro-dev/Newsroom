type Topic = {
  id: number;
  title: string;
  role: string;
};

type Question = {
  id: number;
  keywords: string;
  text: string;
  topic_id: number; // Changed from topic to topic_id to match the model
};

type Video = {
  id: number;
  question_id: number;
  video_id: string; // Changed from number to string
  description: string;
  thumbnail: string;
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
};

type Favourite = {
  id?: number;
  entity_id: number;
  entity_type: 'article' | 'video';
};



export type { Article, Question, Topic, Video, Favourite };
