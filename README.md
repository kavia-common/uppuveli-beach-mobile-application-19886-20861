# Uppuveli Beach Mobile Application

This repository contains the Flutter MobileApplication container for the Uppuveli Beach by DSK project.

## Getting Started

1) Prerequisites
- Flutter SDK (as per CI, Flutter >= 3.29, Dart >= 3.7)
- Android SDK / iOS toolchain as applicable

2) Install dependencies
- From the MobileApplication folder:
  flutter pub get

3) Environment configuration
- Copy the provided .env.example to .env:
  cp .env.example .env
- Set API_BASE to your environment:
  - Android emulator (backend on host): API_BASE=http://10.0.2.2:8000
  - iOS simulator (backend on host): API_BASE=http://localhost:8000
  - Physical device (same LAN as host): API_BASE=http://<your-host-LAN-ip>:8000
  - Production: API_BASE=https://api.uppuvelibeach.com

The app uses flutter_dotenv to load .env at runtime. The .env file has already been added to pubspec assets.

4) Run the app
- flutter run

## Architecture Notes

- lib/config.dart exposes AppConfig.apiBase which reads API_BASE from .env with sensible defaults for debugging.
- lib/main.dart initializes dotenv, sets up Provider-based AuthState and defines routes for:
  - /login (LoginPage)
  - /register (RegisterPage)
  - /rooms (RoomsListPage)
  - /book (BookingCreatePage)
  - /loyalty (LoyaltyPage)

These are placeholders for subsequent tasks that will integrate with the Backend API.

## Testing

- flutter test

## Troubleshooting

- If the Android emulator can't reach your backend on localhost, use 10.0.2.2 (Android emulator’s host alias).
- Ensure your .env has a valid API_BASE and that the backend CORS allows the app if needed.