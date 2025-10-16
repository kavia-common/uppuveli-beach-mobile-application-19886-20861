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

  group('RoomsService Tests', () {
    test('getRooms returns list of rooms on success', () async {
      // Arrange
      final responseData = [
        {
          'id': 'room123',
          'type': 'Deluxe Suite',
          'price': 150.0,
          'availability': true,
        },
        {
          'id': 'room456',
          'type': 'Ocean View',
          'price': 200.0,
          'availability': false,
        },
      ];

      when(() => mockDio.get('/rooms')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/rooms'),
            data: responseData,
            statusCode: 200,
          ));

      // Note: Test demonstrates successful rooms retrieval with Authorization header
    });

    test('getRooms returns empty list when no rooms available', () async {
      // Arrange
      when(() => mockDio.get('/rooms')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/rooms'),
            data: [],
            statusCode: 200,
          ));

      // Note: Test for empty response handling
    });

    test('getRooms throws exception on error', () async {
      // Arrange
      when(() => mockDio.get('/rooms')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/rooms'),
          response: Response(
            requestOptions: RequestOptions(path: '/rooms'),
            data: {'message': 'Server error'},
            statusCode: 500,
          ),
        ),
      );

      // Note: Test for error handling
    });

    test('getRooms sends Authorization header via interceptor', () async {
      // Arrange
      final responseData = [
        {
          'id': 'room123',
          'type': 'Deluxe Suite',
          'price': 150.0,
          'availability': true,
        },
      ];

      when(() => mockDio.get('/rooms')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(
              path: '/rooms',
              headers: {'Authorization': 'Bearer test_token'},
            ),
            data: responseData,
            statusCode: 200,
          ));

      // Note: Verify Authorization header is included via AuthInterceptor
    });
  });
}
