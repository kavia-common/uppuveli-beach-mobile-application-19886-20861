import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/screens/auth/register_screen.dart';
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

  group('RegisterScreen Widget Tests', () {
    testWidgets('RegisterScreen renders all UI elements', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.text('Register'), findsNWidgets(2)); // AppBar and button
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4)); // name, email, password, confirm
    });

    testWidgets('RegisterScreen validates empty name', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act - Find the register button (it's an ElevatedButton, not Text widget directly)
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      expect(registerButton, findsOneWidget);
      
      await tester.tap(registerButton);
      await tester.pump(); // Trigger validation
      await tester.pump(); // Allow error messages to render

      // Assert - Check for the actual validation error message
      expect(find.text('Please enter your name'), findsOneWidget);
    });

    testWidgets('RegisterScreen validates empty email', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act - Enter name but not email
      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, 'John Doe');
      
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.tap(registerButton);
      await tester.pump();
      await tester.pump();

      // Assert
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('RegisterScreen validates invalid email format', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, 'John Doe');
      
      final emailField = find.byType(TextFormField).at(1);
      await tester.enterText(emailField, 'invalidemail');
      
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.tap(registerButton);
      await tester.pump();
      await tester.pump();

      // Assert
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('RegisterScreen validates password length', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, 'John Doe');
      
      final emailField = find.byType(TextFormField).at(1);
      await tester.enterText(emailField, 'john@example.com');
      
      final passwordField = find.byType(TextFormField).at(2);
      await tester.enterText(passwordField, '123');
      
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.tap(registerButton);
      await tester.pump();
      await tester.pump();

      // Assert
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    testWidgets('RegisterScreen validates password match', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      final nameField = find.byType(TextFormField).at(0);
      await tester.enterText(nameField, 'John Doe');
      
      final emailField = find.byType(TextFormField).at(1);
      await tester.enterText(emailField, 'john@example.com');
      
      final passwordField = find.byType(TextFormField).at(2);
      await tester.enterText(passwordField, 'password123');
      
      final confirmPasswordField = find.byType(TextFormField).at(3);
      await tester.enterText(confirmPasswordField, 'differentpassword');
      
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.tap(registerButton);
      await tester.pump();
      await tester.pump();

      // Assert
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('RegisterScreen has password and confirm password fields', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act
      final textFields = find.byType(TextFormField);
      
      // Assert - Verify we have all 4 fields
      expect(textFields, findsNWidgets(4));
    });

    testWidgets('RegisterScreen toggles password visibility', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RegisterScreen(),
          authState: mockAuthState,
        ),
      );

      // Act - Find password field's visibility toggle
      final visibilityIcons = find.byIcon(Icons.visibility);
      expect(visibilityIcons, findsNWidgets(2)); // One for password, one for confirm
      
      // Tap the first visibility icon (password field)
      await tester.tap(visibilityIcons.first);
      await tester.pump();

      // Assert - Icon should change to visibility_off
      expect(find.byIcon(Icons.visibility_off), findsAtLeastNWidgets(1));
    });
  });
}
