import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/screens/auth/login_screen.dart';
import 'package:MobileApplication/state/auth_state.dart';
import '../helpers/test_helpers.dart';

void main() {
  late AuthState mockAuthState;

  setUpAll(() async {
    await initializeTestEnvironment();
  });

  setUp(() {
    mockAuthState = AuthState();
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen renders all UI elements', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.text('Uppuveli Beach'), findsOneWidget);
      expect(find.text('by DSK'), findsOneWidget);
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Login'), findsOneWidget);
      expect(find.text("Don't have an account? Register"), findsOneWidget);
    });

    testWidgets('LoginScreen validates empty email', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('LoginScreen validates invalid email format', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('LoginScreen validates empty password', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('LoginScreen toggles password visibility', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Act - Find password field and enter text
      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, 'password123');
      await tester.pumpAndSettle();

      // Find and tap visibility toggle icon
      final visibilityIcon = find.byIcon(Icons.visibility);
      await tester.tap(visibilityIcon);
      await tester.pumpAndSettle();

      // Assert - Icon should change to visibility_off
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('LoginScreen shows loading state on submit', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const LoginScreen(),
          authState: mockAuthState,
        ),
      );

      // Act - Enter valid credentials
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');
      
      // Tap login and only pump once (don't wait for async to complete)
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Assert - Loading indicator should appear immediately
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // Clean up - pump and settle to let async operations complete
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });
  });
}
