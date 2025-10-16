import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('User fromJson creates valid User object', () {
      // Arrange
      final json = {
        'id': 'user123',
        'email': 'test@example.com',
        'name': 'Test User',
        'loyaltyPoints': 100,
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.id, 'user123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.loyaltyPoints, 100);
    });

    test('User toJson creates valid JSON map', () {
      // Arrange
      const user = User(
        id: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        loyaltyPoints: 100,
      );

      // Act
      final json = user.toJson();

      // Assert
      expect(json['id'], 'user123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'Test User');
      expect(json['loyaltyPoints'], 100);
    });

    test('User JSON roundtrip preserves data', () {
      // Arrange
      const originalUser = User(
        id: 'user456',
        email: 'roundtrip@test.com',
        name: 'Roundtrip User',
        loyaltyPoints: 250,
      );

      // Act
      final json = originalUser.toJson();
      final deserializedUser = User.fromJson(json);

      // Assert
      expect(deserializedUser.id, originalUser.id);
      expect(deserializedUser.email, originalUser.email);
      expect(deserializedUser.name, originalUser.name);
      expect(deserializedUser.loyaltyPoints, originalUser.loyaltyPoints);
    });
  });
}
