import 'package:flutter_driver/flutter_driver.dart';

// This class is meant to house any repeatedly used functions
// That are screen agnostic.

class BaseScreen {
  late FlutterDriver _driver;

// Constructor
  BaseScreen(FlutterDriver driver) {
    this._driver = driver;
  }

  // There is no way to test for existence in flutter.
  // This try catch waits for the element which is similar
  Future<bool> verifyExists(
      SerializableFinder finder, FlutterDriver driver, int timeout) async {
    try {
      await _driver.waitFor(finder, timeout: Duration(milliseconds: timeout));
      return Future.value(true);
    } catch (exception) {
      return Future.value(false);
    }
  }
}
