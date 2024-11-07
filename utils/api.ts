import { Article, Question, HandleNotification } from './types';

const API_BASE_URL = 'http://127.0.0.1:5000'

export async function fetchQuestions(): Promise<Question[]> {
  const res = await fetch(`${API_BASE_URL}/Questions`)
  return res.json()
}

export async function fetchFavorites(): Promise<Article[]> {
  const res = await fetch(`${API_BASE_URL}/Favorites`)
  return res.json()
}

export async function fetchNewsForTopic(topic: string): Promise<Article[]> {
  const res = await fetch(`${API_BASE_URL}/${topic.replace(" ", "_")}`)
  return res.json()
}

export async function deleteNewsItem(id: number, topic: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/${topic.replace(" ", "_")}/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function addFavorite(article: Article): Promise<Article> {

  article.fav_id = article.id.toString()+"_"+article.question_id;

  const response = await fetch(`${API_BASE_URL}/Favorites`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(article)
  });
  if (!response.ok) {
    throw new Error(`Failed to add favorite: ${response.statusText}`);
  }
  return response.json();
}

export async function removeFavorite(id: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/Favorites/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favorite: ${response.statusText}`);
  }
}
