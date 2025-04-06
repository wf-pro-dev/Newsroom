import { Article, Favourite, newQuestion, Question, Topic, Video } from './types';

const API_BASE_URL = 'http://192.168.86.26/api'

/* GET METHODS */

export async function fetchAllData(): Promise<any> {
  const response = await fetch(`${API_BASE_URL}/all_data`)
  return response.json()
}

export async function fetchTopics(): Promise<Topic[]> {
  const response = await fetch(`${API_BASE_URL}/topics`)
  return response.json()
}

export async function fetchFavorites(): Promise<Favourite[]> {
  const response = await fetch(`${API_BASE_URL}/favourites`)
  return response.json()
}

export async function fetchQuestions(): Promise<Question[]> {
  const response = await fetch(`${API_BASE_URL}/questions`)
  return response.json()
}


export async function fetchArticles(): Promise<Article[]> {
  const response = await fetch(`${API_BASE_URL}/articles`)
  return response.json()
}

export async function fetchVideos(): Promise<Video[]> {
  const response = await fetch(`${API_BASE_URL}/videos`)
  return response.json()
}

/* POST METHODS */

export async function addQuestion(topic_id:number): Promise<newQuestion[]> {
  try {
      const response = await fetch(`${API_BASE_URL}/questions/${topic_id}`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json',
          },
      });

      if (!response.ok) {
          throw new Error(`Failed to add new question: ${response.status}`);
      }

      const data : newQuestion[] = await response.json();
      console.log('Generated question:', data);
      return data;
  } catch (error) {
      console.error('Error generating question:', error);
  }

}

/* DELETE METHODS */

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

export async function deleteQuestionbyId(id: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/questions/${id}`, {
    method: 'DELETE',
  });
  if (!response.ok) {
    throw new Error(`Failed to delete question item: ${response.statusText}`);
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
