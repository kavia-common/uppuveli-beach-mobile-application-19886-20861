import axios from "axios";

// PUBLIC_INTERFACE
export const getApiBaseUrl = () => {
  /** Returns the API base URL configured via environment variable. */
  const base = process.env.REACT_APP_API_BASE_URL || "http://localhost:3001/api/v1";
  return base.replace(/\/+$/, "");
};

const api = axios.create({
  baseURL: getApiBaseUrl(),
  headers: {
    "Content-Type": "application/json",
  },
});

// Attach token from localStorage if present
api.interceptors.request.use((config) => {
  const token = localStorage.getItem("authToken");
  if (token) {
    config.headers = config.headers || {};
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

/**
 * Handle API errors:
 * - 401: redirect to login
 * - Network/CORS: provide clearer message to UI while logging full error to console
 */
api.interceptors.response.use(
  (response) => response,
  (error) => {
    // Network or CORS blocked: no response object available
    if (!error || !error.response) {
      const message =
        (error && error.message) || "Network error";
      const augmented = new Error(
        /Network Error/i.test(message)
          ? "Network/CORS error: Unable to reach API. Check REACT_APP_API_BASE_URL and backend CORS for http://localhost:3000."
          : message
      );
      augmented.original = error;
      // Log technical details for developers
      // eslint-disable-next-line no-console
      console.error("API network/CORS error:", error);
      return Promise.reject(augmented);
    }

    if (error.response.status === 401) {
      localStorage.removeItem("authToken");
      // Preserve path for redirect after login
      const currentPath = window.location.pathname + window.location.search;
      const target = `/login?next=${encodeURIComponent(currentPath)}`;
      if (window.location.pathname !== "/login") {
        window.location.replace(target);
      }
    }
    return Promise.reject(error);
  }
);

export default api;
