import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:MobileApplication/state/auth_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'test_secure_storage_mock.dart';

/// Initialize test environment with dotenv and secure storage mock
Future<void> initializeTestEnvironment() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Setup mock secure storage to avoid MissingPluginException
  setupMockSecureStorage();
  
  dotenv.testLoad(fileInput: '''
API_BASE_URL=https://api.test.uppuvelibeach.com/api/v1
API_TIMEOUT=30
''');
}

/// Build a widget with all necessary providers for testing
Widget buildTestWidget({
  required Widget child,
  AuthState? authState,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthState>.value(
        value: authState ?? AuthState(),
      ),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}

/// Build a widget with router for navigation testing
Widget buildTestWidgetWithRouter({
  required Widget child,
  AuthState? authState,
  String? initialRoute,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthState>.value(
        value: authState ?? AuthState(),
      ),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}
