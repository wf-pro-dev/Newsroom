import { Article, Favourite, Video } from "@/utils/types";
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
function id_to_obj(favourites:Favourite[],articles: Article[], videos: Video[]) {
  const result = { "favArticles": new Array<Article>, "favVideos": new Array<Video>};
  console.log(articles)
  for (let i = 0; i < favourites.length; i++) {

    if (favourites[i].entity_type == "article") { result.favArticles.push(articles.find((art)=> art.id == favourites[i].entity_id)!); }
    if (favourites[i].entity_type == "video") { result.favVideos.push(videos.find((vid)=> vid.id == favourites[i].entity_id)!) }

  }
  return result;
}

export {cn, mixArray,id_to_obj}