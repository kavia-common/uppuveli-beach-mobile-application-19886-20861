# Uppuveli Beach Web Admin Panel

Minimal functional React admin panel for managing bookings, loyalty, boutique, notifications, and chat.

## Quick Start

1) Copy environment file
- cp .env.example .env
- Ensure REACT_APP_API_BASE_URL points to your BackendAPI (default: http://localhost:3001/api/v1)

2) Install dependencies
- npm install
- If you see build errors about missing packages (e.g., react-router-dom), run npm install again to update the lockfile.

3) Run
- npm start
- App URL: http://localhost:3000

CORS: the backend must allow http://localhost:3000 origin.

## Authentication

- Login path: /login
- The app posts to `${REACT_APP_API_BASE_URL}/auth/login` with {email,password}
- Expected response either:
  - { token: "JWT..." } OR { status: "success", data: { token: "JWT..." } }
- The token is stored in localStorage as "authToken".
- API client attaches "Authorization: Bearer <token)" header.
- On 401, client clears token and redirects to /login preserving the original path via next param.

## Protected Routes

The following routes require authentication and will redirect to /login if there is no token:
- /bookings: List, create, update, delete bookings
- /loyalty: List accounts and update points/tier
- /boutique: List, create, update, delete items
- /notifications: Send a notification
- /chat: List messages and send new message

Public route:
- /login: Admin login

## Files

- src/api/client.js: Axios client with token handling and 401 redirect
- src/api/endpoints.js: Endpoint path constants
- src/pages/Login.jsx: Auth form
- src/pages/Bookings.jsx: CRUD bookings UI
- src/pages/Loyalty.jsx: List + update loyalty accounts
- src/pages/Boutique.jsx: CRUD boutique
- src/pages/Notifications.jsx: Send notifications
- src/pages/Chat.jsx: List + send chat messages
- src/components/NavBar.jsx: Top navigation with logout
- src/App.js: Router and protected routes

## Backend Endpoint Expectations

- POST /auth/login -> returns token as described above
- Bookings: GET /bookings, POST /bookings, PUT /bookings/:id, DELETE /bookings/:id
- Loyalty: GET /loyalty, PUT /loyalty/:id
- Boutique: GET /boutique, POST /boutique, PUT /boutique/:id, DELETE /boutique/:id
- Notifications: POST /notifications
- Chat: GET /chat, POST /chat

Responses may be raw arrays/objects or wrapped under {data: ...}. The UI handles both.

## Development Notes

- Minimal UI (no UI framework); basic forms and tables only
- Ensure CORS is configured on backend for http://localhost:3000
- To change API URL, update .env and restart dev server
- The router is bootstrapped in src/App.js with react-router-dom v6 and BrowserRouter. ProtectedRoute enforces token presence and redirects with a next param for post-login return.
