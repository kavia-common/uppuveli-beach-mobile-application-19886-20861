import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/booking.dart';

void main() {
  group('Booking Model Tests', () {
    test('Booking fromJson creates valid Booking object', () {
      // Arrange
      final json = {
        'id': 'booking123',
        'userId': 'user123',
        'roomId': 'room123',
        'status': 'confirmed',
        'checkIn': '2024-01-15',
        'checkOut': '2024-01-20',
      };

      // Act
      final booking = Booking.fromJson(json);

      // Assert
      expect(booking.id, 'booking123');
      expect(booking.userId, 'user123');
      expect(booking.roomId, 'room123');
      expect(booking.status, 'confirmed');
      expect(booking.checkIn, '2024-01-15');
      expect(booking.checkOut, '2024-01-20');
    });

    test('Booking toJson creates valid JSON map', () {
      // Arrange
      const booking = Booking(
        id: 'booking123',
        userId: 'user123',
        roomId: 'room123',
        status: 'confirmed',
        checkIn: '2024-01-15',
        checkOut: '2024-01-20',
      );

      // Act
      final json = booking.toJson();

      // Assert
      expect(json['id'], 'booking123');
      expect(json['userId'], 'user123');
      expect(json['roomId'], 'room123');
      expect(json['status'], 'confirmed');
      expect(json['checkIn'], '2024-01-15');
      expect(json['checkOut'], '2024-01-20');
    });

    test('Booking JSON roundtrip preserves data', () {
      // Arrange
      const originalBooking = Booking(
        id: 'booking456',
        userId: 'user456',
        roomId: 'room456',
        status: 'pending',
        checkIn: '2024-02-10',
        checkOut: '2024-02-15',
      );

      // Act
      final json = originalBooking.toJson();
      final deserializedBooking = Booking.fromJson(json);

      // Assert
      expect(deserializedBooking.id, originalBooking.id);
      expect(deserializedBooking.userId, originalBooking.userId);
      expect(deserializedBooking.roomId, originalBooking.roomId);
      expect(deserializedBooking.status, originalBooking.status);
      expect(deserializedBooking.checkIn, originalBooking.checkIn);
      expect(deserializedBooking.checkOut, originalBooking.checkOut);
    });
  });
}
