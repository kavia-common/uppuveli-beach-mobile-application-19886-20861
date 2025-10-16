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

  group('ChatService Tests', () {
    test('sendMessage returns ChatMessage on success', () async {
      // Arrange
      final requestData = {'message': 'Hello, I need assistance'};
      final responseData = {
        'id': 'msg123',
        'userId': 'user123',
        'message': 'Hello! How can I help you?',
        'timestamp': '2024-01-15T10:30:00Z',
      };

      when(() => mockDio.post('/chat', data: requestData))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/chat'),
                data: responseData,
                statusCode: 200,
              ));

      // Note: Test successful chat message sending
    });

    test('sendMessage throws exception on error', () async {
      // Arrange
      final requestData = {'message': 'Test'};

      when(() => mockDio.post('/chat', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/chat'),
          response: Response(
            requestOptions: RequestOptions(path: '/chat'),
            data: {'message': 'Service unavailable'},
            statusCode: 503,
          ),
        ),
      );

      // Note: Test error handling
    });
  });
}
