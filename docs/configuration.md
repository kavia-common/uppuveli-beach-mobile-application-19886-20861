# Configuration

This app uses a `.env` file (at the repository root) for runtime configuration. A template `.env.example` is provided.

## Steps

1. Copy the example file:
   cp .env.example .env

2. Edit `.env` and set values appropriate for your environment:
   - API_BASE_URL: Base URL of the backend API (e.g., https://api.uppuvelibeach.com/api/v1)
   - API_TIMEOUT: API timeout in milliseconds (e.g., 15000)

3. (Optional) If enabling Firebase Cloud Messaging/push notifications, set:
   - FIREBASE_API_KEY
   - FIREBASE_APP_ID
   - FIREBASE_MESSAGING_SENDER_ID
   - FIREBASE_PROJECT_ID

4. Do not commit `.env` to version control.

## Notes

- The `.env` file is read by the app at runtime through the environment configuration utilities under `lib/core/env.dart`.
- If you change `.env` during development, restart the app to apply changes.
