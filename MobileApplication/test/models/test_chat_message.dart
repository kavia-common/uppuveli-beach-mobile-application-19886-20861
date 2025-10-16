import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/chat_message.dart';

void main() {
  group('ChatMessage Model Tests', () {
    test('ChatMessage fromJson creates valid object', () {
      // Arrange
      final json = {
        'id': 'msg123',
        'userId': 'user123',
        'message': 'Hello, I need assistance',
        'timestamp': '2024-01-15T10:30:00Z',
      };

      // Act
      final chatMessage = ChatMessage.fromJson(json);

      // Assert
      expect(chatMessage.id, 'msg123');
      expect(chatMessage.userId, 'user123');
      expect(chatMessage.message, 'Hello, I need assistance');
      expect(chatMessage.timestamp, '2024-01-15T10:30:00Z');
    });

    test('ChatMessage toJson creates valid JSON map', () {
      // Arrange
      const chatMessage = ChatMessage(
        id: 'msg123',
        userId: 'user123',
        message: 'Hello, I need assistance',
        timestamp: '2024-01-15T10:30:00Z',
      );

      // Act
      final json = chatMessage.toJson();

      // Assert
      expect(json['id'], 'msg123');
      expect(json['userId'], 'user123');
      expect(json['message'], 'Hello, I need assistance');
      expect(json['timestamp'], '2024-01-15T10:30:00Z');
    });

    test('ChatMessage JSON roundtrip preserves data', () {
      // Arrange
      const originalMessage = ChatMessage(
        id: 'msg456',
        userId: 'user456',
        message: 'Thank you for your help',
        timestamp: '2024-01-15T11:00:00Z',
      );

      // Act
      final json = originalMessage.toJson();
      final deserializedMessage = ChatMessage.fromJson(json);

      // Assert
      expect(deserializedMessage.id, originalMessage.id);
      expect(deserializedMessage.userId, originalMessage.userId);
      expect(deserializedMessage.message, originalMessage.message);
      expect(deserializedMessage.timestamp, originalMessage.timestamp);
    });
  });
}
