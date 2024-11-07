
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

type HandleNotification = () => {
  setShowNotification: React.Dispatch<React.SetStateAction<boolean>>;
  setShowDeleteNotification: React.Dispatch<React.SetStateAction<boolean>>;
}

export type { Article, Question, HandleNotification };
