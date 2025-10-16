import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/room.dart';

void main() {
  group('Room Model Tests', () {
    test('Room fromJson creates valid Room object', () {
      // Arrange
      final json = {
        'id': 'room123',
        'type': 'Deluxe Suite',
        'price': 150.0,
        'availability': true,
      };

      // Act
      final room = Room.fromJson(json);

      // Assert
      expect(room.id, 'room123');
      expect(room.type, 'Deluxe Suite');
      expect(room.price, 150.0);
      expect(room.availability, true);
    });

    test('Room toJson creates valid JSON map', () {
      // Arrange
      const room = Room(
        id: 'room123',
        type: 'Deluxe Suite',
        price: 150.0,
        availability: true,
      );

      // Act
      final json = room.toJson();

      // Assert
      expect(json['id'], 'room123');
      expect(json['type'], 'Deluxe Suite');
      expect(json['price'], 150.0);
      expect(json['availability'], true);
    });

    test('Room JSON roundtrip preserves data', () {
      // Arrange
      const originalRoom = Room(
        id: 'room456',
        type: 'Ocean View',
        price: 200.5,
        availability: false,
      );

      // Act
      final json = originalRoom.toJson();
      final deserializedRoom = Room.fromJson(json);

      // Assert
      expect(deserializedRoom.id, originalRoom.id);
      expect(deserializedRoom.type, originalRoom.type);
      expect(deserializedRoom.price, originalRoom.price);
      expect(deserializedRoom.availability, originalRoom.availability);
    });
  });
}
