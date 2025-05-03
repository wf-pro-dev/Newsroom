import { Article, Video } from "@/utils/types";
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

 function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

function mixArray(articles: Article[], videos: Video[], chunkSize: number): Array< Article | Video> {
  const result = [];
  let j = 0;
  for (let i = 0; i < articles.length || j < videos.length; i++) {
    if (videos[j] && ((i > 0 && i % chunkSize == 0) || i >= articles.length)) { videos[j]["type"] = "video"; result.push(videos[j]); j++ }
    if (articles[i]) { articles[i]["type"] = "article"; result.push(articles[i]); }
  }
  return result;
}

export {cn, mixArray}
