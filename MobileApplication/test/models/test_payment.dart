import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/models/payment.dart';

void main() {
  group('Payment Model Tests', () {
    test('Payment fromJson creates valid Payment object', () {
      // Arrange
      final json = {
        'id': 'payment123',
        'bookingId': 'booking123',
        'amount': 500.0,
        'status': 'completed',
        'method': 'credit_card',
      };

      // Act
      final payment = Payment.fromJson(json);

      // Assert
      expect(payment.id, 'payment123');
      expect(payment.bookingId, 'booking123');
      expect(payment.amount, 500.0);
      expect(payment.status, 'completed');
      expect(payment.method, 'credit_card');
    });

    test('Payment toJson creates valid JSON map', () {
      // Arrange
      const payment = Payment(
        id: 'payment123',
        bookingId: 'booking123',
        amount: 500.0,
        status: 'completed',
        method: 'credit_card',
      );

      // Act
      final json = payment.toJson();

      // Assert
      expect(json['id'], 'payment123');
      expect(json['bookingId'], 'booking123');
      expect(json['amount'], 500.0);
      expect(json['status'], 'completed');
      expect(json['method'], 'credit_card');
    });

    test('Payment JSON roundtrip preserves data', () {
      // Arrange
      const originalPayment = Payment(
        id: 'payment456',
        bookingId: 'booking456',
        amount: 750.5,
        status: 'pending',
        method: 'paypal',
      );

      // Act
      final json = originalPayment.toJson();
      final deserializedPayment = Payment.fromJson(json);

      // Assert
      expect(deserializedPayment.id, originalPayment.id);
      expect(deserializedPayment.bookingId, originalPayment.bookingId);
      expect(deserializedPayment.amount, originalPayment.amount);
      expect(deserializedPayment.status, originalPayment.status);
      expect(deserializedPayment.method, originalPayment.method);
    });
  });
}
