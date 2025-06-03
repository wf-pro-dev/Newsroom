import { mixArray } from '@/src/lib/utils';
import { API_BASE_URL, ROUTES, CONTENT_TYPES } from '@/src/lib/constants';
import { 
  Article, 
  Favourite, 
  newQuestion, 
  Question, 
  Topic, 
  User, 
  Video 
} from '@/src/lib/types';

let csrfTokenCache: string | null = null;

/* AUTH METHODS */

export async function fetchCsrfToken(): Promise<string> {
  if (csrfTokenCache) {
    return csrfTokenCache;
  }

  const response = await fetch(`${API_BASE_URL}${ROUTES.CSRF_TOKEN}`, {
    credentials: 'include'
  });
  const data = await response.json();

  csrfTokenCache = data.csrfToken;
  return csrfTokenCache!;
}

export async function register(
  username: string, 
  email: string, 
  password: string, 
  csrfToken: string
) {
  const response = await fetch(`${API_BASE_URL}${ROUTES.REGISTER}`, {
    method: 'POST',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken
    },
    body: JSON.stringify({ username, email, password })
  });

  if (!response.ok) {
    throw new Error(`Failed to register user: ${response.statusText}`);
  }

  const data = await response.json();
  return { data, ok: response.ok };
}

export async function login(email: string, password: string, csrfToken: string) {
  const response = await fetch(`${API_BASE_URL}${ROUTES.LOGIN}`, {
    method: 'POST',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken
    },
    body: JSON.stringify({ email, password })
  });

  if (!response.ok) {
    throw new Error(`Failed to login user: ${response.statusText}`);
  }
  return response.json();
}

export async function logout() {
  const response = await fetch(`${API_BASE_URL}${ROUTES.LOGOUT}`, {
    method: 'POST',
    credentials: 'include',
    headers: { 'Content-Type': 'application/json' }
  });

  if (!response.ok) {
    const errorData = await response.json().catch(() => ({}));
    console.error('Logout error details:', errorData);
    throw new Error(`Failed to logout user: ${response.statusText}`);
  }

  return response.json();
}

/* USER METHODS */

export async function fetchUser(): Promise<User> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.USER}`, {
    method: 'GET',
    credentials: 'include',
  });

  if (!response.ok) {
    throw new Error(`Unauthorized or failed to fetch user: ${response.statusText}`);
  }

  return response.json();
}

/* DATA FETCHING METHODS */

export async function fetchAllData(): Promise<Record<string, unknown>> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.ALL_DATA}`);
  return response.json();
}

export async function fetchQuestions(): Promise<Question[]> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.QUESTIONS}`, { 
    credentials: "include" 
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch questions: ${response.statusText}`);
  }

  const data = await response.json();
  return data["questions"];
}

export async function fetchArticles(): Promise<Article[]> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.ARTICLES}`, { 
    credentials: "include" 
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch articles: ${response.statusText}`);
  }

  const data = await response.json();
  return data["articles"];
}

export async function fetchVideos(): Promise<Video[]> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.VIDEOS}`, { 
    credentials: "include" 
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch videos: ${response.statusText}`);
  }

  const data = await response.json();
  return data["videos"];
}

export async function fetchTopics(): Promise<Topic[]> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.TOPICS}`);
  return response.json();
}

/* FAVORITES METHODS */

export async function fetchFavorites(): Promise<Favourite[]> {
  let articles = [];
  let videos = [];

  try {
    const respArticles = await fetch(`${API_BASE_URL}${ROUTES.FAVORITES}/articles`, { 
      credentials: "include" 
    });
    articles = await respArticles.json();

    const respVideos = await fetch(`${API_BASE_URL}${ROUTES.FAVORITES}/videos`, { 
      credentials: "include" 
    });
    videos = await respVideos.json();
  } catch (error) {
    throw new Error(`Failed to fetch favorites: ${error}`);
  }

  return mixArray(articles, videos, 4) as Favourite[];
}

export async function addFavourite(
  contentId: number, 
  contentType: "article" | "video"
): Promise<Favourite> {
  const body = contentType === CONTENT_TYPES.ARTICLE 
    ? { article_id: contentId } 
    : { video_id: contentId };
  
  const response = await fetch(`${API_BASE_URL}${ROUTES.FAVORITES}/add/${contentType}`, {
    method: 'POST',
    credentials: "include",
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  
  if (!response.ok) {
    throw new Error(`Failed to add favourite: ${response.statusText}`);
  }

  const data = await response.json();
  return { ...data["favorite"], type: contentType };
}

export async function deleteFavouritebyId(
  favId: number, 
  contentType: string
): Promise<void> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.FAVORITES}/delete/${contentType}/${favId}`, {
    method: 'DELETE',
    credentials: "include",
    headers: { 'Content-Type': 'application/json' }
  });

  if (!response.ok) {
    throw new Error(`Failed to delete favourite: ${response.statusText}`);
  }
}

/* QUESTION METHODS */

export async function addQuestion(topicId: number, csrfToken: string): Promise<newQuestion[]> {
  try {
    const response = await fetch(`${API_BASE_URL}${ROUTES.QUESTIONS}/${topicId}/add`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': csrfToken,
      }
    });

    if (!response.ok) {
      throw new Error(`Failed to add new question: ${response.status}`);
    }

    const data: newQuestion[] = await response.json();
    return data;
  } catch (error) {
    console.error('Error adding question:', error);
    throw error;
  }
}

export async function refreshQuestion(
  questionId: number, 
  csrfToken: string
): Promise<newQuestion> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.QUESTIONS}/${questionId}/refresh`, {
    method: 'PUT',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken,
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to refresh question: ${response.statusText}`);
  }

  return response.json();
}

export async function hideQuestion(questionId: number): Promise<Record<string, unknown>> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.QUESTIONS}/${questionId}/hide`, {
    method: 'PUT',
    credentials: "include",
    headers: { 'Content-Type': 'application/json' }
  });

  if (!response.ok) {
    throw new Error(`Failed to hide question: ${response.statusText}`);
  }

  return response.json();
}

/* CONTENT MANAGEMENT METHODS */

export async function hideContent(contentId: number, contentType: string): Promise<Record<string, unknown>> {
  const response = await fetch(`${API_BASE_URL}/${contentType}s/${contentId}/hide`, {
    method: 'PUT',
    credentials: "include",
    headers: { 'Content-Type': 'application/json' }
  });

  if (!response.ok) {
    throw new Error(`Failed to hide ${contentType}: ${response.statusText}`);
  }

  return response.json();
}

export async function deleteArticlebyId(id: number, csrfToken: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.ARTICLES}/${id}/delete`, {
    method: 'DELETE',
    credentials: "include",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken,
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to delete article: ${response.statusText}`);
  }
}

export async function deleteVideobyId(id: number, csrfToken: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}${ROUTES.VIDEOS}/${id}/delete`, {
    method: 'DELETE',
    credentials: "include",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-TOKEN': csrfToken,
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to delete video: ${response.statusText}`);
  }
} 