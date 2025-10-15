import 'package:flutter_test/flutter_test.dart';
import 'package:MobileApplication/main.dart';

void main() {
  testWidgets('App renders Login by default and shows API banner', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Sign in'), findsOneWidget);
    // The API banner shows "API: ..."
    expect(find.textContaining('API:'), findsOneWidget);
  });

  testWidgets('Navigate to register screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap "Create an account"
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    expect(find.text('Create account'), findsOneWidget);
  });
}
