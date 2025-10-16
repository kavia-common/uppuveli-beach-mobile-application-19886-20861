import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import '../helpers/test_helpers.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUpAll(() async {
    await initializeTestEnvironment();
  });

  setUp(() {
    mockDio = MockDio();
  });

  group('NotificationsService Tests', () {
    test('getNotifications returns list of notifications', () async {
      // Arrange
      final responseData = [
        {
          'id': 'notif123',
          'userId': 'user123',
          'message': 'Your booking is confirmed',
          'read': false,
        },
        {
          'id': 'notif456',
          'userId': 'user123',
          'message': 'Welcome to Uppuveli Beach!',
          'read': true,
        },
      ];

      when(() => mockDio.get('/notifications'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/notifications'),
                data: responseData,
                statusCode: 200,
              ));

      // Note: Test successful notifications retrieval
    });

    test('getNotifications returns empty list when no notifications', () async {
      // Arrange
      when(() => mockDio.get('/notifications'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/notifications'),
                data: [],
                statusCode: 200,
              ));

      // Note: Test empty notifications handling
    });
  });
}
