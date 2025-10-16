import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/screens/rooms/rooms_list_screen.dart';
import 'package:MobileApplication/state/auth_state.dart';
import 'package:MobileApplication/core/api_client.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import '../helpers/test_helpers.dart';

void main() {
  late AuthState mockAuthState;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUpAll(() async {
    await initializeTestEnvironment();
  });

  setUp(() {
    mockAuthState = AuthState();
    
    // Create a Dio instance with mock adapter
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.test.uppuvelibeach.com/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dioAdapter = DioAdapter(dio: dio);
    
    // Replace the ApiClient instance with our mock
    ApiClient.instance = dio;
  });

  group('RoomsListScreen Widget Tests', () {
    testWidgets('RoomsListScreen renders app bar', (WidgetTester tester) async {
      // Arrange - Mock the API to return empty list
      dioAdapter.onGet(
        '/rooms',
        (server) => server.reply(200, []),
      );

      // Act
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
      // Arrange - Mock the API with delayed response
      dioAdapter.onGet(
        '/rooms',
        (server) => server.reply(200, [], delay: const Duration(seconds: 1)),
      );

      // Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Assert - Initial loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('RoomsListScreen displays rooms after successful load', (WidgetTester tester) async {
      // Arrange - Mock successful API response
      dioAdapter.onGet(
        '/rooms',
        (server) => server.reply(200, [
          {
            'id': '1',
            'type': 'Deluxe Room',
            'price': 150.0,
            'availability': true,
          },
          {
            'id': '2',
            'type': 'Standard Room',
            'price': 100.0,
            'availability': false,
          },
        ]),
      );

      // Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Wait for initial load
      await tester.pump();
      // Wait for async operations and animations to complete
      await tester.pumpAndSettle();

      // Assert - Rooms are displayed
      expect(find.text('Deluxe Room'), findsOneWidget);
      expect(find.text('Standard Room'), findsOneWidget);
      expect(find.text('\$150.00 per night'), findsOneWidget);
      expect(find.text('\$100.00 per night'), findsOneWidget);
    });

    testWidgets('RoomsListScreen displays error after failed load', (WidgetTester tester) async {
      // Arrange - Mock failed API response
      dioAdapter.onGet(
        '/rooms',
        (server) => server.reply(500, {'message': 'Server error'}),
      );

      // Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Wait for initial load
      await tester.pump();
      // Wait for all async operations to complete
      await tester.pumpAndSettle();

      // Assert - Error message and retry button are shown
      expect(find.text('Server error'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('RoomsListScreen shows "No rooms available" for empty list', (WidgetTester tester) async {
      // Arrange - Mock empty response
      dioAdapter.onGet(
        '/rooms',
        (server) => server.reply(200, []),
      );

      // Act
      await tester.pumpWidget(
        buildTestWidget(
          child: const RoomsListScreen(),
          authState: mockAuthState,
        ),
      );

      // Wait for async operations to complete
      await tester.pump();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No rooms available'), findsOneWidget);
    });
  });
}
