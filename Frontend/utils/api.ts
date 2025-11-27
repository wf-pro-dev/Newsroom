import { mixArray } from '@/lib/utils';
import { Article, Collection, Favourite, Item, newQuestion, Question, Topic, User, Video } from './types';

const API_BASE_URL = 'https://wwwill.dedyn.io/newsroom/api/v1'

let csrfTokenCache: string | null = null;

/* GET METHODS */

export async function fetchCsrfToken() {
  // Return cached token if available
  if (csrfTokenCache) {
    return csrfTokenCache;
  }

  const response = await fetch(`${API_BASE_URL}/csrf-token`, {
    credentials: 'include'
  });
  const data = await response.json();

  // Cache the token
  csrfTokenCache = data.csrfToken;
  return csrfTokenCache;
}

export async function fetchUser(): Promise<User> {
  const response = await fetch(`${API_BASE_URL}/user`, {
    method: 'GET',
    credentials: 'include',
  });

  if (!response.ok) {
    // Handle specific authentication errors
    if (response.status === 401) {
      const errorText = await response.text().catch(() => 'Authentication failed');
      throw new Error(`Authentication required: ${errorText}`);
    } else if (response.status === 422) {
      // This usually means the JWT is malformed or missing
      const errorText = await response.text().catch(() => 'Invalid authentication token');
      throw new Error(`Invalid token: ${errorText}`);
    }
    throw new Error(`Failed to fetch user: ${response.status} ${response.statusText}`);
  }

  const data = await response.json()
  return data;
}

export async function fetchAllData(): Promise<Record<string, unknown>> {
  const response = await fetch(`${API_BASE_URL}/all_data`)
  return response.json()
}

export async function fetchQuestions(): Promise<Question[]> {
  const response = await fetch(`${API_BASE_URL}/questions`, { credentials: "include" })

  if (!response.ok) {
    throw new Error(`Failed to fetch user articles : ${response.statusText}`);
  }

  const data = await response.json()
  return data["questions"]
}

export async function fetchArticles(): Promise<Article[]> {
  const response = await fetch(`${API_BASE_URL}/articles`, { credentials: "include" })

  if (!response.ok) {
    throw new Error(`Failed to fetch user articles : ${response.statusText}`);
  }

  const data = await response.json()
  return data["articles"]
}

export async function fetchVideos(): Promise<Video[]> {
  const response = await fetch(`${API_BASE_URL}/videos`, { credentials: "include" })

  if (!response.ok) {
    throw new Error(`Failed to fetch user videos : ${response.statusText}`);
  }

  const data = await response.json()
  return data["videos"]
}

export async function fetchFavorites(): Promise<Favourite[]> {

  let articles = []
  let videos = []

  try {
    const resp_articles = await fetch(`${API_BASE_URL}/favorites/articles`, { credentials: "include" })
    articles = await resp_articles.json()

    const resp_videos = await fetch(`${API_BASE_URL}/favorites/videos`, { credentials: "include" })
    videos = await resp_videos.json()
  }
  catch (error) {
    throw new Error(`failed to fetch favorite ${error}`)
  }

  return mixArray(articles, videos, 4) as Favourite[]
}


export async function fetchTopics(): Promise<Topic[]> {
  const response = await fetch(`${API_BASE_URL}/topics`)
  return response.json()
}

export async function fetchCollections(): Promise<Collection[]> {
  const response = await fetch(`${API_BASE_URL}/collections`, { credentials: "include" })
  if (!response.ok) {
    throw new Error(`Failed to fetch collections: ${response.statusText}`);
  } 
  const collections: Collection[] = await response.json()
  return collections
}

export async function fetchItems(collection_id: number): Promise<Item[]> {
  const response = await fetch(`${API_BASE_URL}/collections/${collection_id}/items`, { credentials: "include" })
  if (!response.ok) {
    throw new Error(`Failed to fetch items: ${response.statusText}`);
  }
  const items: Item[] = await response.json()
  return items
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

  const data = await response.json();
  return { data, ok: response.ok };

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

export async function logout() {

  const response = await fetch(`${API_BASE_URL}/logout`, {
    method: 'POST',
    credentials: 'include',  // Send cookies
    headers: { 'Content-Type': 'application/json' }
  });

  if (!response.ok) {
    const errorData = await response.json().catch(() => ({}));
    console.error('Logout error details:', errorData); // More detailed error logging
    throw new Error(`Failed to logout user: ${response.statusText}`);
  }

  const data = await response.json();
  return data;
}

export async function addFavourite(content_id: number, content_type: "article" | "video"): Promise<Favourite> {
  
  const body = content_type === "article" ? { article_id: content_id } : { video_id: content_id }
  
  const response = await fetch(`${API_BASE_URL}/favorites/add/${content_type}`, {
    method: 'POST',
    credentials: "include",
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  
  if (!response.ok) {
    throw new Error(`Failed to add favourite: ${response.statusText}`);
  }

  const data = await response.json()
  return { ...data["favorite"], type: content_type };
}

export async function addQuestion(topic_id: number, csrfToken: string): Promise<newQuestion[]> {
  try {
    const response = await fetch(`${API_BASE_URL}/questions/${topic_id}/add`, {
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

export async function hideContent(content_id: number, content_type: string): Promise<{message: string}> {
  const response = await fetch(`${API_BASE_URL}/content/${content_type}/${content_id}/hide`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: "include",
    body: JSON.stringify({ content_id, content_type })
  });
  if (!response.ok) {
    throw new Error(`Failed to hide ${content_type} ${content_id}: ${response.statusText}`);
  }

  const data = await response.json()
  return data;
}

export async function hideQuestion(question_id: number): Promise<{message: string}> {
  const response = await fetch(`${API_BASE_URL}/question/${question_id}/hide`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: "include",
    body: JSON.stringify({ question_id })
  });
  if (!response.ok) {
    throw new Error(`Failed to hide question ${question_id}: ${response.statusText}`);
  }

  const data = await response.json()
  return data;
}

export async function refreshQuestion(question_id: number, csrfToken: string): Promise<newQuestion> {
  const response = await fetch(`${API_BASE_URL}/refresh/${question_id}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken 
    },
    credentials: "include",
  });
  if (!response.ok) {
    throw new Error(`Failed to refresh question ${question_id}: ${response.statusText}`);
  }

  const data = await response.json()
  return data;
}

export async function createCollection(name: string): Promise<Collection> {
  const response = await fetch(`${API_BASE_URL}/collections/create/${name}`, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json'},
  });
  if (!response.ok) {
    throw new Error(`Failed to create collection ${name}: ${response.statusText}`);
  }

  const collection: Collection = await response.json()
  return collection;
}

export async function addToCollection(collectionId: number, content_type: string, content_id: number): Promise<Item> {
  const response = await fetch(`${API_BASE_URL}/collections/${collectionId}/content/type/${content_type}/id/${content_id}`, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json'},
  });
  if (!response.ok) {
    throw new Error(`Failed to add content to collection: ${response.statusText}`);
  }

  const data : Item = await response.json()
  return data
}

/* DELETE METHODS */

export async function deleteArticlebyId(id: number, csrfToken: string): Promise<void> {
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

export async function deleteVideobyId(id: number, csrfToken: string): Promise<void> {
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

export async function deleteFavouritebyId(fav_id: number,content_type: string): Promise<void> {

  const response = await fetch(`${API_BASE_URL}/favorites/delete/${content_type}/${fav_id}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
  });
  if (!response.ok) {
    throw new Error(`Failed to remove favourite: ${response.statusText}`);
  }
}

export async function deleteCollection(collectionId: number): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/collections/delete/${collectionId}`, {
    method: 'DELETE',
    credentials: 'include', // Sends JWT cookie automatically
  });
  if (!response.ok) {
    throw new Error(`Failed to delete collection: ${response.statusText}`);
  }
}
