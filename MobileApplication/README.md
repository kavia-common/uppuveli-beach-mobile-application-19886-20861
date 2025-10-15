# Uppuveli Beach by DSK - Mobile Application

A Flutter mobile application for Uppuveli Beach resort, providing guests with a seamless experience for room bookings, payments, loyalty programs, referrals, notifications, and communication.

## Features

- **Authentication**: User registration and login with JWT token security
- **Room Booking**: Browse available rooms and create reservations
- **Payments**: Process payments for bookings through multiple methods
- **Loyalty Program**: View and track loyalty points and history
- **Referral System**: Submit referral codes and earn rewards
- **Notifications**: Receive and view personalized notifications
- **Chat**: Communicate with hotel staff via integrated chat
- **Profile Management**: View profile and manage settings

## Prerequisites

- Flutter SDK (>=3.7.0)
- Dart SDK (>=3.7.0)
- Android Studio / Xcode for mobile development
- A configured backend API at the URL specified in `.env`

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure Environment

Create a `.env` file in the root of the MobileApplication directory:

```bash
cp .env.example .env
```

Edit `.env` and set your API base URL:

```
API_BASE_URL=https://api.uppuvelibeach.com/api/v1
API_TIMEOUT=30
```

### 3. Generate JSON Serialization Code

Run the build_runner to generate model serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the Application

For Android:
```bash
flutter run
```

For iOS:
```bash
flutter run
```

For a specific device:
```bash
flutter devices
flutter run -d <device_id>
```

## Project Structure

```
lib/
├── core/                   # Core utilities
│   ├── api_client.dart    # HTTP client configuration
│   ├── auth_interceptor.dart  # JWT interceptor
│   ├── env.dart           # Environment configuration
│   └── storage/
│       └── secure_storage.dart  # Secure token storage
├── models/                # Data models
│   ├── user.dart
│   ├── room.dart
│   ├── booking.dart
│   ├── payment.dart
│   ├── loyalty.dart
│   ├── referral.dart
│   ├── notification_item.dart
│   └── chat_message.dart
├── services/              # API services
│   ├── auth_service.dart
│   ├── rooms_service.dart
│   ├── bookings_service.dart
│   ├── payments_service.dart
│   ├── loyalty_service.dart
│   ├── referrals_service.dart
│   ├── notifications_service.dart
│   └── chat_service.dart
├── state/                 # State management
│   ├── auth_state.dart
│   └── app_providers.dart
├── screens/               # UI screens
│   ├── auth/
│   ├── rooms/
│   ├── bookings/
│   ├── payments/
│   ├── loyalty/
│   ├── referrals/
│   ├── notifications/
│   ├── chat/
│   └── profile/
├── theme/
│   └── app_theme.dart     # App theming
├── app_router.dart        # Navigation
└── main.dart              # Entry point
```

## Architecture

- **State Management**: Provider pattern for reactive state
- **HTTP Client**: Dio with interceptors for authentication and error handling
- **Secure Storage**: flutter_secure_storage for JWT tokens
- **Navigation**: Named routes with arguments
- **Models**: JSON serialization with json_serializable

## API Integration

The app connects to the backend REST API with the following endpoints:

- `POST /register` - User registration
- `POST /login` - User authentication
- `GET /rooms` - Fetch available rooms
- `POST /bookings` - Create booking
- `POST /payments` - Process payment
- `GET /loyalty` - Get loyalty info
- `POST /referrals` - Submit referral
- `GET /notifications` - Fetch notifications
- `POST /chat` - Send chat message

All authenticated endpoints require a Bearer JWT token in the Authorization header.

## Security

- JWT tokens stored securely using flutter_secure_storage
- Automatic token attachment via HTTP interceptor
- Automatic logout on 401 Unauthorized responses
- Encrypted shared preferences on Android

## Build for Production

### Android

```bash
flutter build apk --release
```

or for app bundle:

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Testing

Run unit tests:

```bash
flutter test
```

Run widget tests:

```bash
flutter test test/widget_test.dart
```

## Troubleshooting

### Build Runner Issues

If you encounter issues with generated files, try:

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Dependency Conflicts

Update dependencies:

```bash
flutter pub upgrade
```

### Platform-Specific Issues

For Android: Ensure Android SDK is properly configured
For iOS: Ensure Xcode and CocoaPods are properly installed

## Environment Variables

The following environment variables can be configured in `.env`:

- `API_BASE_URL`: Backend API base URL (required)
- `API_TIMEOUT`: API request timeout in seconds (default: 30)

## Support

For issues or questions, use the in-app chat feature or contact support at support@uppuvelibeach.com

## License

Proprietary - Uppuveli Beach by DSK
