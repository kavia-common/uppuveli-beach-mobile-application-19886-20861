const TOKEN_KEY = "authToken";

// PUBLIC_INTERFACE
export function getToken() {
  /** Get JWT token from localStorage */
  return localStorage.getItem(TOKEN_KEY);
}

// PUBLIC_INTERFACE
export function setToken(token) {
  /** Persist JWT token to localStorage */
  if (token) localStorage.setItem(TOKEN_KEY, token);
}

// PUBLIC_INTERFACE
export function clearToken() {
  /** Remove JWT token from localStorage */
  localStorage.removeItem(TOKEN_KEY);
}

// PUBLIC_INTERFACE
export function isAuthenticated() {
  /** Returns true if a token is available */
  return !!getToken();
}
