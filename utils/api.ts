import { Article, Favourite, newQuestion, Question, Topic, User, Video } from './types';

const API_BASE_URL = 'http://52.14.169.156/api'

/* GET METHODS */
export async function fetchCsrfToken() {
  const response = await fetch(`${API_BASE_URL}/csrf-token`, {
    credentials: 'include'  // Required for cookies
  })
  const data = await response.json()
  return data.csrfToken
}

export async function fetchUser(csrfToken: string): Promise<User | null> {
  const response = await fetch(`${API_BASE_URL}/user`, {
    method: 'GET',
    credentials: 'include', // Sends JWT cookie automatically
    headers: {
      'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
    },
  });
  if (!response.ok) {
    return null
  }

  return response.json()
}


export async function fetchAllData(): Promise<any> {
  const response = await fetch(`${API_BASE_URL}/all_data`)
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

export async function fetchFavorites(): Promise<Favourite[]> {
  const response = await fetch(`${API_BASE_URL}/favourites`)
  return response.json()
}

export async function fetchQuestions(): Promise<Question[]> {
  const response = await fetch(`${API_BASE_URL}/questions`)
  return response.json()
}

export async function fetchTopics(): Promise<Topic[]> {
  const response = await fetch(`${API_BASE_URL}/topics`)
  return response.json()
}


/* POST METHODS */
export async function register(username: string, email: string, password: string, csrfToken: string) {
  const response = await fetch(`${API_BASE_URL}/register`, {
    method: 'POST',
    credentials: 'include',  // Send cookies
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken  // Attach CSRF token
    },
    body: JSON.stringify({ username, email, password })
  })

  if (!response.ok) {
    throw new Error(`Failed to register user: ${response.statusText}`);
  }
  return { "data": response.json(), "ok": response.ok };

}

export async function login(email: string, password: string, csrfToken: string) {
  const response = await fetch(`${API_BASE_URL}/login`, {
    method: 'POST',
    credentials: 'include',  // Send cookies
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken  // Attach CSRF token
    },
    body: JSON.stringify({ email, password })
  })

  if (!response.ok) {
    throw new Error(`Failed to login user: ${response.statusText}`);
  }
  return response.json();

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

export async function addQuestion(topic_id: number, csrfToken: string): Promise<newQuestion[]> {
  try {
    const response = await fetch(`${API_BASE_URL}/questions/${topic_id}`, {
      method: 'POST',
      credentials: 'include', // Sends JWT cookie automatically
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
      }
    });
    if (!response.ok) {
      throw new Error(`Failed to add new question: ${response.status}`);
    }

    const data: newQuestion[] = await response.json();
    console.log('Generated question:', data);
    return data;
  } catch (error) {
    console.error('Error generating question:', error);
  }
  return []
}

/* DELETE METHODS */

export async function deleteArticlebyId(id: number, csrfToken:string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/articles/delete/${id}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
    headers: {
      'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
    }
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function deleteVideobyId(id: number, csrfToken:string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/videos/delete/${id}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
    headers: {
      'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
    }
  });
  if (!response.ok) {
    throw new Error(`Failed to delete news item: ${response.statusText}`);
  }
}

export async function deleteQuestionbyId(id: number, csrfToken:string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/questions/delete/${id}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
    headers: {
      'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
    }
  });
  if (!response.ok) {
    throw new Error(`Failed to delete question item: ${response.statusText}`);
  }
}

export async function deleteFavouritebyId(type: string, id: number, csrfToken:string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/favourites/${type}/${id}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
    headers: {
      'X-CSRF-TOKEN': csrfToken, // Manually attach CSRF token
    }
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favourite: ${response.statusText}`);
  }
}
