// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../screens/home_screen.dart';
import 'package:flap_app/main.dart';

void main() {
  testWidgets('Form error validation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify no errors present at first
    expect(HomeScreen().emailEmptyError, findsNothing);
    expect(HomeScreen().emailCheckError, findsNothing);
    expect(HomeScreen().passwordEmptyError, findsNothing);
    expect(HomeScreen().passwordCheckError, findsNothing);

    // Trigger empty error state for email
    await tester.tap(HomeScreen().loginButton);
    // need delay for error to show
    await tester.pump(const Duration(milliseconds: 100));
    expect(HomeScreen().emailEmptyError, findsOneWidget);
    expect(HomeScreen().emailCheckError, findsNothing);
    expect(HomeScreen().passwordEmptyError, findsNothing);
    expect(HomeScreen().passwordCheckError, findsNothing);

    // Tap the email field and trigger a frame. Then enter text
    await tester.tap(HomeScreen().emailField);
    await tester.enterText(HomeScreen().emailField, "test@test.com");
    // Trigger empty error state for password
    await tester.tap(HomeScreen().loginButton);
    // need delay for error to show
    await tester.pump(const Duration(milliseconds: 100));
    expect(HomeScreen().emailEmptyError, findsNothing);
    expect(HomeScreen().emailCheckError, findsNothing);
    expect(HomeScreen().passwordEmptyError, findsOneWidget);
    expect(HomeScreen().passwordCheckError, findsNothing);

    // Tap the password field and trigger a frame. Then enter text
    await tester.tap(HomeScreen().passwordField);
    await tester.enterText(HomeScreen().passwordField, "testPass!");
    // Trigger check error states
    await tester.tap(HomeScreen().loginButton);
    // need longer delay for error to show due to animation
    await tester.pump(const Duration(seconds: 500));
    expect(HomeScreen().emailEmptyError, findsNothing);
    expect(HomeScreen().emailCheckError, findsOneWidget);
    expect(HomeScreen().passwordEmptyError, findsNothing);
    expect(HomeScreen().passwordCheckError, findsOneWidget);
  });
}
