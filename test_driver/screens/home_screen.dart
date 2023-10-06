import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreen {
  late FlutterDriver _driver;

// Constructor
  HomeScreen(FlutterDriver driver) {
    this._driver = driver;
  }

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
