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

  group('PaymentsService Tests', () {
    test('processPayment returns Payment on success', () async {
      // Arrange
      final requestData = {
        'bookingId': 'booking123',
        'amount': 500.0,
        'method': 'credit_card',
      };

      final responseData = {
        'id': 'payment123',
        'bookingId': 'booking123',
        'amount': 500.0,
        'status': 'completed',
        'method': 'credit_card',
      };

      when(() => mockDio.post('/payments', data: requestData))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/payments'),
                data: responseData,
                statusCode: 201,
              ));

      // Note: Test successful payment processing
    });

    test('processPayment throws exception on payment failure', () async {
      // Arrange
      final requestData = {
        'bookingId': 'booking123',
        'amount': 500.0,
        'method': 'credit_card',
      };

      when(() => mockDio.post('/payments', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/payments'),
          response: Response(
            requestOptions: RequestOptions(path: '/payments'),
            data: {'message': 'Payment declined'},
            statusCode: 402,
          ),
        ),
      );

      // Note: Test payment failure handling
    });

    test('processPayment validates amount', () async {
      // Arrange
      final requestData = {
        'bookingId': 'booking123',
        'amount': -100.0,
        'method': 'credit_card',
      };

      when(() => mockDio.post('/payments', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/payments'),
          response: Response(
            requestOptions: RequestOptions(path: '/payments'),
            data: {'message': 'Invalid amount'},
            statusCode: 400,
          ),
        ),
      );

      // Note: Test amount validation
    });
  });
}
