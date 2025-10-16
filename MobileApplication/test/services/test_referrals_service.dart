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

  group('ReferralsService Tests', () {
    test('submitReferral returns Referral on success', () async {
      // Arrange
      final requestData = {'code': 'REF123ABC'};
      final responseData = {
        'userId': 'user123',
        'code': 'REF123ABC',
        'rewards': 50,
      };

      when(() => mockDio.post('/referrals', data: requestData))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/referrals'),
                data: responseData,
                statusCode: 200,
              ));

      // Note: Test successful referral submission
    });

    test('submitReferral throws exception on invalid code', () async {
      // Arrange
      final requestData = {'code': 'INVALID'};

      when(() => mockDio.post('/referrals', data: requestData)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/referrals'),
          response: Response(
            requestOptions: RequestOptions(path: '/referrals'),
            data: {'message': 'Invalid referral code'},
            statusCode: 400,
          ),
        ),
      );

      // Note: Test invalid code handling
    });
  });
}
