import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/referral.dart';

void main() {
  group('Referral Model Tests', () {
    test('Referral fromJson creates valid Referral object', () {
      // Arrange
      final json = {
        'userId': 'user123',
        'code': 'REF123ABC',
        'rewards': 50,
      };

      // Act
      final referral = Referral.fromJson(json);

      // Assert
      expect(referral.userId, 'user123');
      expect(referral.code, 'REF123ABC');
      expect(referral.rewards, 50);
    });

    test('Referral toJson creates valid JSON map', () {
      // Arrange
      const referral = Referral(
        userId: 'user123',
        code: 'REF123ABC',
        rewards: 50,
      );

      // Act
      final json = referral.toJson();

      // Assert
      expect(json['userId'], 'user123');
      expect(json['code'], 'REF123ABC');
      expect(json['rewards'], 50);
    });

    test('Referral JSON roundtrip preserves data', () {
      // Arrange
      const originalReferral = Referral(
        userId: 'user456',
        code: 'REF456XYZ',
        rewards: 100,
      );

      // Act
      final json = originalReferral.toJson();
      final deserializedReferral = Referral.fromJson(json);

      // Assert
      expect(deserializedReferral.userId, originalReferral.userId);
      expect(deserializedReferral.code, originalReferral.code);
      expect(deserializedReferral.rewards, originalReferral.rewards);
    });
  });
}
