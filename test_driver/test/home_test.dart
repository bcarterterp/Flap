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
    final homeScreen = HomeScreen(driver);
    print(homeScreen.title);
    print("output");
    // Basic app health check
    test("check health", () async {
      // Based on given example in documentation
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('test page elements', () async {
      // Define any elements needed to perform assertions at the top
      final emailExists =
          homeScreen.verifyExists(homeScreen.emailField, driver, 500);
      print(homeScreen.title);
      //final passwordExists = HomeScreen(driver)
      //    .verifyExists(HomeScreen(driver).passwordField, driver, 500);

      // Assertions below
      //expect(await driver.getText(HomeScreen(driver).title),
      //    "Please Enter Credentials");
      // expect(await driver.getText(HomeScreen(driver).loginButton), "Login");
      expect(await emailExists, isTrue);
      //expect(await passwordExists, isTrue);
    });
/*
    test('test login functionality', () async {
      // Elements
      final emailErrorExists = HomeScreen(driver)
          .verifyExists(HomeScreen(driver).emailError, driver, 500);
      final passwordErrorExists = HomeScreen(driver)
          .verifyExists(HomeScreen(driver).passwordError, driver, 500);
      // First trigger error state by clicking login
      driver.tap(HomeScreen(driver).loginButton);
      // Test and make sure error state is present on email field
      expect(emailErrorExists, isTrue);
      // Enter text into email field
      await driver.tap(HomeScreen(driver).emailField);
      await driver.enterText("test@test.com");
      // Test and make sure error state is present on password field, and
      // email error is now gone
      driver.tap(HomeScreen(driver).loginButton);
      expect(passwordErrorExists, isTrue);
      expect(emailErrorExists, isFalse);
      // Enter text in password field and assert that both error texts
      // are gone
      await driver.tap(HomeScreen(driver).passwordField);
      await driver.enterText("testPassword!");
      expect(passwordErrorExists, isFalse);
      expect(emailErrorExists, isFalse);
    });
    */
  });
}
