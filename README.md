# Uppuveli Beach by DSK – Mobile Application

This repository contains the Flutter mobile application for Uppuveli Beach by DSK. Refer to the `MobileApplication` folder for the Flutter project.

## Environment Setup

1. Copy the example environment file to create your local `.env`:
   cp .env.example .env

2. Set the required variables in `.env`:
   - API_BASE_URL (required): Base URL of the backend API, e.g. https://api.uppuvelibeach.com/api/v1
   - API_TIMEOUT (required): Timeout in milliseconds, e.g. 15000

3. Optional Firebase keys if enabling push notifications:
   - FIREBASE_API_KEY
   - FIREBASE_APP_ID
   - FIREBASE_MESSAGING_SENDER_ID
   - FIREBASE_PROJECT_ID

See docs/configuration.md for more details.

Note: Do not commit `.env` to version control.
