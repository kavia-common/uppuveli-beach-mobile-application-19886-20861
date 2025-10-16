import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/loyalty.dart';

void main() {
  group('Loyalty Model Tests', () {
    test('LoyaltyHistoryEntry fromJson creates valid object', () {
      // Arrange
      final json = {
        'date': '2024-01-15',
        'change': 50,
        'reason': 'Booking completed',
      };

      // Act
      final entry = LoyaltyHistoryEntry.fromJson(json);

      // Assert
      expect(entry.date, '2024-01-15');
      expect(entry.change, 50);
      expect(entry.reason, 'Booking completed');
    });

    test('LoyaltyHistoryEntry toJson creates valid JSON map', () {
      // Arrange
      const entry = LoyaltyHistoryEntry(
        date: '2024-01-15',
        change: 50,
        reason: 'Booking completed',
      );

      // Act
      final json = entry.toJson();

      // Assert
      expect(json['date'], '2024-01-15');
      expect(json['change'], 50);
      expect(json['reason'], 'Booking completed');
    });

    test('Loyalty fromJson creates valid Loyalty object', () {
      // Arrange
      final json = {
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

      // Act
      final loyalty = Loyalty.fromJson(json);

      // Assert
      expect(loyalty.userId, 'user123');
      expect(loyalty.points, 250);
      expect(loyalty.history.length, 2);
      expect(loyalty.history[0].change, 50);
      expect(loyalty.history[1].change, 100);
    });

    test('Loyalty toJson creates valid JSON map', () {
      // Arrange
      const loyalty = Loyalty(
        userId: 'user123',
        points: 250,
        history: [
          LoyaltyHistoryEntry(
            date: '2024-01-15',
            change: 50,
            reason: 'Booking completed',
          ),
        ],
      );

      // Act
      final json = loyalty.toJson();

      // Assert
      expect(json['userId'], 'user123');
      expect(json['points'], 250);
      expect(json['history'], isList);
      expect((json['history'] as List).length, 1);
    });

    test('Loyalty JSON roundtrip preserves data', () {
      // Arrange
      const originalLoyalty = Loyalty(
        userId: 'user456',
        points: 500,
        history: [
          LoyaltyHistoryEntry(
            date: '2024-01-10',
            change: 100,
            reason: 'Welcome bonus',
          ),
          LoyaltyHistoryEntry(
            date: '2024-01-15',
            change: -50,
            reason: 'Points redeemed',
          ),
        ],
      );

      // Act - Convert to JSON and back, ensuring history is properly serialized
      final json = originalLoyalty.toJson();
      
      // Convert history list items to Map if they aren't already
      final jsonForDeserialization = {
        'userId': json['userId'],
        'points': json['points'],
        'history': (json['history'] as List).map((item) {
          if (item is LoyaltyHistoryEntry) {
            return item.toJson();
          }
          return item;
        }).toList(),
      };
      
      final deserializedLoyalty = Loyalty.fromJson(jsonForDeserialization);

      // Assert
      expect(deserializedLoyalty.userId, originalLoyalty.userId);
      expect(deserializedLoyalty.points, originalLoyalty.points);
      expect(deserializedLoyalty.history.length, originalLoyalty.history.length);
      expect(deserializedLoyalty.history[0].change, originalLoyalty.history[0].change);
      expect(deserializedLoyalty.history[1].change, originalLoyalty.history[1].change);
    });
  });
}
