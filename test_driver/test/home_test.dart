// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../screens/home_screen.dart';

void main() {
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Home Tests', () {
    test('test page elements', () async {
      // Define screen for more readable code
      final homeScreen = HomeScreen(driver);

      // Define any elements needed to perform assertions at the top
      final emailExists =
          homeScreen.verifyExists(homeScreen.emailField, driver, 500);
      final passwordExists =
          homeScreen.verifyExists(homeScreen.passwordField, driver, 500);

      // Assertions below
      expect(
          await driver.getText(homeScreen.title), "Please Enter Credentials");
      expect(await driver.getText(homeScreen.loginButton), "Login");
      expect(await emailExists, isTrue);
      expect(await passwordExists, isTrue);
    });

    test('test login error display', () async {
      // Define screen for more readable code
      final homeScreen = HomeScreen(driver);

      // Elements
      final emailEmptyErrorExists = driver.getText(homeScreen.emailEmptyError);
      final passwordEmptyErrorExists =
          driver.getText(homeScreen.passwordEmptyError);
      final emailCheckErrorExists = driver.getText(homeScreen.emailCheckError);
      final passwordCheckErrorExists =
          driver.getText(homeScreen.passwordCheckError);

      // First trigger error state by clicking login
      await driver.tap(homeScreen.loginButton);
      // Test and make sure error states are loaded
      expect(await emailEmptyErrorExists, "Email is empty");
      // Enter text into email field then trigger password error
      await driver.tap(homeScreen.emailField);
      await driver.enterText("test@test.com");
      await driver.tap(homeScreen.loginButton);
      expect(await passwordEmptyErrorExists, "Password is empty");
      // Enter text into password field then hit login
      await driver.tap(homeScreen.passwordField);
      await driver.enterText("testPassword!");
      driver.tap(homeScreen.loginButton);
      // Assert new error message is present
      expect(await emailCheckErrorExists, "Check your email");
      expect(await passwordCheckErrorExists, "Check your password");
      // Note: driver doesn't support understanding of if elements
      // are still "visible". For things like determining if an element
      // is still present, its better to use integration or widget tests
      // to ensure error scenarios are triggering when expected
      // Please see home_widget_test.dart
    });
  });
}
