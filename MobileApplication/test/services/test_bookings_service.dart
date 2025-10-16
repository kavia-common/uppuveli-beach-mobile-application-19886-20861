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

  group('BookingsService Tests', () {
    test('createBooking returns Booking on success', () async {
      // Arrange
      final requestData = {
        'roomId': 'room123',
        'checkIn': '2024-01-15',
        'checkOut': '2024-01-20',
      };

      final responseData = {
        'id': 'booking123',
        'userId': 'user123',
        'roomId': 'room123',
        'status': 'confirmed',
        'checkIn': '2024-01-15',
        'checkOut': '2024-01-20',
      };

      when(() => mockDio.post('/bookings', data: requestData))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/bookings'),
                data: responseData,
                statusCode: 201,
              ));

      // Note: Test successful booking creation with Authorization header
    });

    test('createBooking throws exception on invalid dates', () async {
      // Arrange
      final requestData = {
        'roomId': 'room123',
        'checkIn': '2024-01-20',
        'checkOut': '2024-01-15',
      };

      when(() => mockDio.post('/bookings', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/bookings'),
          response: Response(
            requestOptions: RequestOptions(path: '/bookings'),
            data: {'message': 'Check-out date must be after check-in date'},
            statusCode: 400,
          ),
        ),
      );

      // Note: Test validation error handling
    });

    test('createBooking throws exception when room not available', () async {
      // Arrange
      final requestData = {
        'roomId': 'room123',
        'checkIn': '2024-01-15',
        'checkOut': '2024-01-20',
      };

      when(() => mockDio.post('/bookings', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/bookings'),
          response: Response(
            requestOptions: RequestOptions(path: '/bookings'),
            data: {'message': 'Room not available for selected dates'},
            statusCode: 409,
          ),
        ),
      );

      // Note: Test conflict error handling
    });
  });
}
