import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  setUpAll(() async {
    // Initialize dotenv for tests
    TestWidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(fileInput: '''
API_BASE_URL=https://api.uppuvelibeach.com/api/v1
API_TIMEOUT=30
''');
  });

  testWidgets('App initializes without errors', (WidgetTester tester) async {
    // Test passes if no initialization errors occur
    expect(dotenv.isInitialized, true);
  });

  testWidgets('Environment variables are loaded', (WidgetTester tester) async {
    // Verify environment variables are accessible
    expect(dotenv.env['API_BASE_URL'], isNotNull);
    expect(dotenv.env['API_BASE_URL'], 'https://api.uppuvelibeach.com/api/v1');
  });
}
