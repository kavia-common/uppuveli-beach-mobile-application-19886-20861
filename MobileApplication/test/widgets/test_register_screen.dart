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

      // Act - Find the register button (last one, as first is AppBar)
      final registerButtons = find.text('Register');
      final registerButton = registerButtons.last;
      await tester.tap(registerButton);
      await tester.pump(); // Trigger validation

      // Assert
      expect(find.text('Please enter your name'), findsOneWidget);
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
  });
}
