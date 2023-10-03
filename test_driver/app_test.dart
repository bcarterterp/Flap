// Imports the Flutter Driver API.

import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';

import 'package:test/test.dart';

void main() {
  group('Flutter driver test App', () {
    // First, you can define common Finders/variables and use them to locate widgets from the test suite
    final exampleFinder = find.byValueKey("example");

    var example_data = "example";

    // We can hm,.ook into the button by using it's tooltip, which can be
    // found by going to the widget inspector and clicking on
    // the button in the tree, which will show where in the code
    // it is defined:
    SerializableFinder title = find.text("Flutter Demo Home Page");
    SerializableFinder message =
        find.text("You have pushed the button this many times:");
    SerializableFinder initialCounterText = find.text("0");
    SerializableFinder counterButton = find.byTooltip("Increment");

    const duration = Duration(milliseconds: 500);

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
      // Based on given example in documentation
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('test page elements', () async {
      // Based on given example in documentation
      expect(await driver.getText(title), "Flutter Demo Home Page");
      expect(await driver.getText(message),
          "You have pushed the button this many times:");
      expect(await driver.getText(initialCounterText), "0");
      // There is no way to test for existence in flutter.
      // This try catch waits for the element which is similar
      // TO DO: Put this statement into a reusable custom function
      try {
        await driver.waitFor(counterButton, timeout: duration);
        return true;
      } catch (e) {
        return false;
      }
    });

    test('test increment button', () async {
      // Custom example test. First we define our finders.
      SerializableFinder afterCounterText = find.text("1");
      // Next we await the element that needs to be interacted with
      await driver.waitForTappable(counterButton);
      // Now we ensure the counter is still at 0:
      expect(await driver.getText(initialCounterText), "0");
      // We now tap the FloatingActionButton
      driver.tap(counterButton);
      // We assert that the counter has incremented
      expect(await driver.getText(afterCounterText), "1");
      // Note: we do not need to use two finders if we have something else to hook into
      // like a tooltip or unique type.
    });
  });
}
