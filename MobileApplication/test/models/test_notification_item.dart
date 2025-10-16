import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/notification_item.dart';

void main() {
  group('NotificationItem Model Tests', () {
    test('NotificationItem fromJson creates valid object', () {
      // Arrange
      final json = {
        'id': 'notif123',
        'userId': 'user123',
        'message': 'Your booking is confirmed',
        'read': false,
      };

      // Act
      final notification = NotificationItem.fromJson(json);

      // Assert
      expect(notification.id, 'notif123');
      expect(notification.userId, 'user123');
      expect(notification.message, 'Your booking is confirmed');
      expect(notification.read, false);
    });

    test('NotificationItem toJson creates valid JSON map', () {
      // Arrange
      const notification = NotificationItem(
        id: 'notif123',
        userId: 'user123',
        message: 'Your booking is confirmed',
        read: false,
      );

      // Act
      final json = notification.toJson();

      // Assert
      expect(json['id'], 'notif123');
      expect(json['userId'], 'user123');
      expect(json['message'], 'Your booking is confirmed');
      expect(json['read'], false);
    });

    test('NotificationItem JSON roundtrip preserves data', () {
      // Arrange
      const originalNotification = NotificationItem(
        id: 'notif456',
        userId: 'user456',
        message: 'Welcome to Uppuveli Beach!',
        read: true,
      );

      // Act
      final json = originalNotification.toJson();
      final deserializedNotification = NotificationItem.fromJson(json);

      // Assert
      expect(deserializedNotification.id, originalNotification.id);
      expect(deserializedNotification.userId, originalNotification.userId);
      expect(deserializedNotification.message, originalNotification.message);
      expect(deserializedNotification.read, originalNotification.read);
    });
  });
}
