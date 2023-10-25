// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flap_app/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_screen.dart';

void main() {
  final loginScreen = Logincreen();
  // Note: This group performs the same validation as the integration
  // test example, difference being that these tests do not require
  // launching the app on an emulator for validation
  group('Home Widget Tests', () {
    testWidgets('Initial screen has no error validation',
        (WidgetTester tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Verify no errors present at first
      expect(loginScreen.emailEmptyError, findsNothing);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsNothing);
      expect(loginScreen.passwordCheckError, findsNothing);
    });
    testWidgets('Email empty error validation', (WidgetTester tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Trigger empty error state for email
      await tester.tap(loginScreen.loginButton);
      // pumpAndSettle is used in this case to wait for loading
      // animation to be complete in between login button taps
      await tester.pumpAndSettle();
      expect(loginScreen.emailEmptyError, findsOneWidget);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsNothing);
      expect(loginScreen.passwordCheckError, findsNothing);
    });
    testWidgets('Password empty error validation', (WidgetTester tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Enter email text
      await tester.enterText(loginScreen.emailField, "test@test.com");
      // Trigger empty error state for password
      await tester.tap(loginScreen.loginButton);
      await tester.pumpAndSettle();
      expect(loginScreen.emailEmptyError, findsNothing);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsOneWidget);
      expect(loginScreen.passwordCheckError, findsNothing);
    });
    testWidgets('Check email/password error validation',
        (WidgetTester tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());
      // Enter email text
      await tester.enterText(loginScreen.emailField, "test@test.com");
      // Enter text in password field
      await tester.enterText(loginScreen.passwordField, "testPass!");
      // Trigger check error states
      await tester.tap(loginScreen.loginButton);
      await tester.pumpAndSettle();
      expect(loginScreen.emailEmptyError, findsNothing);
      expect(loginScreen.emailCheckError, findsOneWidget);
      expect(loginScreen.passwordEmptyError, findsNothing);
      expect(loginScreen.passwordCheckError, findsOneWidget);
    });
  });
}
