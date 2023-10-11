// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'screens/home_screen.dart';
import 'package:flap_app/main.dart';

void main() {
  final homeScreen = HomeScreen();
  group('Home Widget Tests', () {
    testWidgets('Form error validation', (WidgetTester tester) async {
      // Note: performs the same validation as the integration
      // test example, difference being that these tests do not require
      // launching the app on an emulator for validation

      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Verify no errors present at first
      expect(homeScreen.emailEmptyError, findsNothing);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsNothing);
      expect(homeScreen.passwordCheckError, findsNothing);

      // Trigger empty error state for email
      await tester.tap(homeScreen.loginButton);
      // pumpAndSettle is used in this case to wait for loading
      // animation to be complete in between login button taps
      await tester.pumpAndSettle();
      expect(homeScreen.emailEmptyError, findsOneWidget);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsNothing);
      expect(homeScreen.passwordCheckError, findsNothing);

      // Enter email text
      await tester.enterText(homeScreen.emailField, "test@test.com");
      // Trigger empty error state for password
      await tester.tap(homeScreen.loginButton);
      await tester.pumpAndSettle();
      expect(homeScreen.emailEmptyError, findsNothing);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsOneWidget);
      expect(homeScreen.passwordCheckError, findsNothing);

      // Enter text in password field
      await tester.enterText(homeScreen.passwordField, "testPass!");
      // Trigger check error states
      await tester.tap(homeScreen.loginButton);
      await tester.pumpAndSettle();
      expect(homeScreen.emailEmptyError, findsNothing);
      expect(homeScreen.emailCheckError, findsOneWidget);
      expect(homeScreen.passwordEmptyError, findsNothing);
      expect(homeScreen.passwordCheckError, findsOneWidget);
    });
  });
}
