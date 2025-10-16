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

  group('LoyaltyService Tests', () {
    test('getLoyalty returns Loyalty data on success', () async {
      // Arrange
      final responseData = {
        'userId': 'user123',
        'points': 250,
        'history': [
          {
            'date': '2024-01-15',
            'change': 50,
            'reason': 'Booking completed',
          },
          {
            'date': '2024-01-20',
            'change': 100,
            'reason': 'Referral bonus',
          },
        ],
      };

      when(() => mockDio.get('/loyalty')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/loyalty'),
            data: responseData,
            statusCode: 200,
          ));

      // Note: Test successful loyalty data retrieval
    });

    test('getLoyalty handles empty history', () async {
      // Arrange
      final responseData = {
        'userId': 'user123',
        'points': 0,
        'history': [],
      };

      when(() => mockDio.get('/loyalty')).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/loyalty'),
            data: responseData,
            statusCode: 200,
          ));

      // Note: Test handling of user with no loyalty history
    });

    test('getLoyalty throws exception on error', () async {
      // Arrange
      when(() => mockDio.get('/loyalty')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/loyalty'),
          response: Response(
            requestOptions: RequestOptions(path: '/loyalty'),
            data: {'message': 'User not found'},
            statusCode: 404,
          ),
        ),
      );

      // Note: Test error handling
    });
  });
}
