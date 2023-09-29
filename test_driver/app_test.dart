// Imports the Flutter Driver API.

import 'package:flutter_driver/flutter_driver.dart';

import 'package:test/test.dart';

void main() {
  group('Flutter driver test App', () {
    // First, you can define common Finders/variables and use them to locate widgets from the test suite

    final exampleFinder = find.byValueKey("example");

    var example_data = "example";

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

    test("check health", () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('test page elements', () async {
      SerializableFinder message = find.text("You have pushed the button this many times:");
      await driver.waitFor(message);
      expect(await driver.getText(message),
          "You have pushed the button this many times:");
    });
  });
}
