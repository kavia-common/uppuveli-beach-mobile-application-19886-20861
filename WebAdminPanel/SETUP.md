WebAdminPanel setup

1) Copy environment file:
   cp .env.example .env
   Ensure REACT_APP_API_BASE_URL=http://localhost:3001/api/v1 (or your backend URL with /api/v1)

2) Install dependencies:
   npm install

3) Run:
   npm start
   Open http://localhost:3000

Notes:
- Axios client adds Authorization: Bearer <token> from localStorage key 'authToken'.
- 401 responses trigger redirect to /login with next param.
- Backend must enable CORS for http://localhost:3000.
- Protected routes: /bookings, /loyalty, /boutique, /notifications, /chat
