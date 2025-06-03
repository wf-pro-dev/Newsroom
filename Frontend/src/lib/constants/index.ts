export const API_BASE_URL = 'https://newsroom.dedyn.io/api';

export const ROUTES = {
  CSRF_TOKEN: '/csrf-token',
  USER: '/user',
  ALL_DATA: '/all_data',
  QUESTIONS: '/questions',
  ARTICLES: '/articles',
  VIDEOS: '/videos',
  FAVORITES: '/favorites',
  TOPICS: '/topics',
  REGISTER: '/register',
  LOGIN: '/login',
  LOGOUT: '/logout',
} as const;

export const CONTENT_TYPES = {
  ARTICLE: 'article',
  VIDEO: 'video',
} as const;

export const PASSWORD_REQUIREMENTS = {
  MIN_LENGTH: 8,
  PATTERNS: {
    UPPERCASE: /[A-Z]/,
    LOWERCASE: /[a-z]/,
    NUMBER: /[0-9]/,
    EMAIL: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
  }
} as const; 