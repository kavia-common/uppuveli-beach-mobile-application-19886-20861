import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/screens/home/home_screen.dart';
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

  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen renders app bar', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const HomeScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.text('Uppuveli Beach'), findsOneWidget);
      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('HomeScreen displays feature cards', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const HomeScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert
      expect(find.text('Services'), findsOneWidget);
      expect(find.text('Rooms'), findsOneWidget);
      expect(find.text('My Bookings'), findsOneWidget);
      expect(find.text('Loyalty'), findsOneWidget);
      expect(find.text('Referrals'), findsOneWidget);
      expect(find.text('Chat'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('HomeScreen has interactive feature cards', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(
          child: const HomeScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert - Verify cards are present and tappable
      expect(find.byType(Card), findsWidgets);
      expect(find.byType(InkWell), findsWidgets);
    });
  });
}
