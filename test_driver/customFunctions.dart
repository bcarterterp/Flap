// This file allows for launching the app through the flutter driver dependancy
// Separate driver process sends instructions to and receives data from the app
// App listens to incoming connections from the driver process
import 'package:flutter_driver/flutter_driver.dart';

class CustomFunctions {
  late FlutterDriver driver;
// Start custom functions
  dynamic exists(var element, int timeout) async {
    // There is no "exists" conditional in driver, so 
    // this function serves to replicate that functinality
    var duration = Duration(milliseconds: timeout);
    try {
      await driver.waitFor(element, timeout: duration);
      return true;
    } catch (e) {
      return false;
    }
  }
}
