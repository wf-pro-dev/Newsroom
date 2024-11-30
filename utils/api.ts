import { Article, Favourite, Question, Topic, Video } from './types';

const API_BASE_URL = 'http://127.0.0.1:5000'

export async function fetchAllData(): Promise<any> {
  const res = await fetch(`${API_BASE_URL}/all_data`)
  return res.json()
}

export async function fetchTopics(): Promise<Topic[]> {
  const res = await fetch(`${API_BASE_URL}/topics`)
  return res.json()
}

export async function fetchFavorites(): Promise<Favourite[]> {
  const res = await fetch(`${API_BASE_URL}/favourites`)
  return res.json()
}

export async function fetchQuestions(): Promise<Question[]> {
  const res = await fetch(`${API_BASE_URL}/questions`)
  return res.json()
}


export async function fetchArticles(): Promise<Article[]> {
  const res = await fetch(`${API_BASE_URL}/articles`)
  return res.json()
}

export async function fetchVideos(): Promise<Video[]> {
  const res = await fetch(`${API_BASE_URL}/videos`)
  return res.json()
}


export async function deleteNewsbyId(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/articles/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function deleteVideobyId(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/videos/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}


export async function addFavourite(entity_id: number, entity_type: string): Promise<any> {
  const response = await fetch(`${API_BASE_URL}/favourites`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ entity_id, entity_type })
  });
  if (!response.ok) {
    throw new Error(`Failed to add favourite: ${response.statusText}`);
  }
  return response.json();
}

export async function removeFavourite(type:string,id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/favourites/${type}/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favourite: ${response.statusText}`);
  }
}
