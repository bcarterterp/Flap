// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'screens/home_screen.dart';

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
  group('Flutter driver test App', () {
    // Define the screen at the top of the group for ease of reading
    //final homeScreen = HomeScreen(driver);
    // First, you can define common Finders/variables and use them to locate widgets from the test suite
    // We can hook into the elements in various ways, which can be
    // found by going to the widget inspector and clicking on
    // the button in the tree, which will show where in the code
    // it is defined:
    SerializableFinder title = find.text("Please Enter Credentials");
    final emailfield = find.bySemanticsLabel('Email');
    final passwordfield = find.bySemanticsLabel('Password');
    SerializableFinder loginButton = find.text("Login");
    const duration = Duration(milliseconds: 500);

    test("check health", () async {
      // Based on given example in documentation
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('test page elements', () async {
      // Based on given example in documentation
      final emailExists =
          HomeScreen(driver).verifyExists(emailfield, driver, 500);
      expect(await driver.getText(title), "Please Enter Credentials");
      expect(await driver.getText(loginButton), "Login");
      final finder = find.text("kkfkaj");
      final passwordExists =
          HomeScreen(driver).verifyExists(title, driver, 500);
      // There is no way to test for existence in flutter.
      // This try catch waits for the element which is similar
      expect(await passwordExists, isTrue);
    });

    test('test login functionality', () async {
      SerializableFinder emailError = find.text("Email is empty");
      SerializableFinder passwordError = find.text("Password is empty");
      // Next we await the element that needs to be interacted with
      await driver.getText(loginButton);
      await driver.tap(emailfield);
      await driver.enterText("test@test.com");
      /*driver.tap(loginButton);
      // Test and make sure error state is present on email field
      driver.tap(loginButton);
      expect(await driver.getText(emailError), "Email is empty");
      // Test and make sure error state is present on password field
      await driver.tap(emailfield);
      driver.enterText("test@test.com");
      driver.tap(loginButton);
      expect(await driver.getText(passwordError), "Password is empty");*/
    });
  });
}
