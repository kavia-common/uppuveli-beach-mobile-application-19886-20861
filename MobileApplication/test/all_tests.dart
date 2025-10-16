import 'package:flutter_test/flutter_test.dart';

// Model tests
import 'models/test_user.dart' as user_test;
import 'models/test_room.dart' as room_test;
import 'models/test_booking.dart' as booking_test;
import 'models/test_payment.dart' as payment_test;
import 'models/test_loyalty.dart' as loyalty_test;
import 'models/test_referral.dart' as referral_test;
import 'models/test_notification_item.dart' as notification_test;
import 'models/test_chat_message.dart' as chat_message_test;

// Service tests
import 'services/test_auth_service.dart' as auth_service_test;
import 'services/test_rooms_service.dart' as rooms_service_test;
import 'services/test_bookings_service.dart' as bookings_service_test;
import 'services/test_payments_service.dart' as payments_service_test;
import 'services/test_loyalty_service.dart' as loyalty_service_test;
import 'services/test_referrals_service.dart' as referrals_service_test;
import 'services/test_notifications_service.dart' as notifications_service_test;
import 'services/test_chat_service.dart' as chat_service_test;

// State tests
import 'state/test_auth_state.dart' as auth_state_test;

// Widget tests
import 'widgets/test_login_screen.dart' as login_screen_test;
import 'widgets/test_register_screen.dart' as register_screen_test;
import 'widgets/test_home_screen.dart' as home_screen_test;
import 'widgets/test_rooms_list_screen.dart' as rooms_list_screen_test;

// Integration tests
import 'integration/test_auth_rooms_flow.dart' as integration_test;

void main() {
  group('All Model Tests', () {
    user_test.main();
    room_test.main();
    booking_test.main();
    payment_test.main();
    loyalty_test.main();
    referral_test.main();
    notification_test.main();
    chat_message_test.main();
  });

  group('All Service Tests', () {
    auth_service_test.main();
    rooms_service_test.main();
    bookings_service_test.main();
    payments_service_test.main();
    loyalty_service_test.main();
    referrals_service_test.main();
    notifications_service_test.main();
    chat_service_test.main();
  });

  group('All State Tests', () {
    auth_state_test.main();
  });

  group('All Widget Tests', () {
    login_screen_test.main();
    register_screen_test.main();
    home_screen_test.main();
    rooms_list_screen_test.main();
  });

  group('All Integration Tests', () {
    integration_test.main();
  });
}
