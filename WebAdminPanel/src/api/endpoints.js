export const endpoints = {
  // Auth
  login: "/auth/login", // expects {email,password} -> {token, user?} or {status,data:{token}}
  token: "/auth/token", // OAuth2 password flow fallback: expects form-data {username,password}
  // Core entities
  bookings: "/bookings",
  loyalty: "/loyalty",
  boutique: "/boutique",
  notifications: "/notifications",
  chat: "/chat",
};

// PUBLIC_INTERFACE
export function withId(base, id) {
  /** Build a path with ID segment */
  return `${base}/${encodeURIComponent(id)}`;
}
