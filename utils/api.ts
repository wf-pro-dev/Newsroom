import { Article, Question, Topic } from './types';

const API_BASE_URL = 'http://127.0.0.1:5000'



export async function fetchTopics(): Promise<Topic[]> {
  const res = await fetch(`${API_BASE_URL}/Topics`)
  return res.json()
}

export async function fetchFavorites(): Promise<Article[]> {
  const res = await fetch(`${API_BASE_URL}/Favorites`)
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


export async function deleteNewsbyId(id: number, topic: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/Articles/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function addFavorite(article: Article): Promise<Article> {

  
  const response = await fetch(`${API_BASE_URL}/Favorites`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(article)
  });
  console.log(response)
  if (!response.ok) {
    throw new Error(`Failed to add favorite: ${response.statusText}`);
  }
  return response.json();
}

export async function removeFavorite(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/Favorites/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favorite: ${response.statusText}`);
  }
}
