import { Article, Question, Topic, Video } from './types';

const API_BASE_URL = 'http://127.0.0.1:5000'



export async function fetchTopics(): Promise<Topic[]> {
  const res = await fetch(`${API_BASE_URL}/Topics`)
  return res.json()
}

export async function fetchFavorites(table:"Fav_Articles"|"Fav_Videos"): Promise<Article[]|Video[]> {
  const res = await fetch(`${API_BASE_URL}/${table}`)
  return res.json()
}

export async function fetchQuestions(): Promise<Question[]> {
  const res = await fetch(`${API_BASE_URL}/Questions`)
  return res.json()
}


export async function fetchArticles(): Promise<Article[]> {
  const res = await fetch(`${API_BASE_URL}/Articles`)
  return res.json()
}

export async function fetchVideos(): Promise<Video[]> {
  const res = await fetch(`${API_BASE_URL}/Videos`)
  return res.json()
}


export async function deleteNewsbyId(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/Articles/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function delteVideobyId(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/Videos/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function addFavorite(table:"Fav_Articles"|"Fav_Videos",obj: Article|Video): Promise<Article|Video> {

  obj["obj_id"] = obj["id"]
  const response = await fetch(`${API_BASE_URL}/${table}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(obj)
  });
  if (!response.ok) {
    throw new Error(`Failed to add favorite: ${response.statusText}`);
  }
  return response.json();
}

export async function removeFavorite(table:"Fav_Articles"|"Fav_Videos",id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/${table}/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favorite: ${response.statusText}`);
  }
}
