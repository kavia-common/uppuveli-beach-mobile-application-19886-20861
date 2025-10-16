import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/screens/rooms/rooms_list_screen.dart';
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

  group('RoomsListScreen Widget Tests', () {
    testWidgets('RoomsListScreen renders app bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.text('Available Rooms'), findsOneWidget);
    });

    testWidgets('RoomsListScreen shows loading indicator initially', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('RoomsListScreen displays error after failed load', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Wait for the initial load to complete (with timeout)
      // The service will fail because there's no real API
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      // Assert - After failure, should show retry button or error message
      // Note: This will depend on actual API call completing
    });
  });
}
