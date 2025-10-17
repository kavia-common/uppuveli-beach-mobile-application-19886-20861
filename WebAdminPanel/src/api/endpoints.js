export const endpoints = {
  // Auth
  login: "/auth/login", // expects {email,password} -> {token, user?} or {status,data:{token}}
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
