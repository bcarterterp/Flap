// This file allows for launching the app through the flutter driver dependancy
// Separate driver process sends instructions to and receives data from the app
// App listens to incoming connections from the driver process
import 'package:flutter_driver/driver_extension.dart';

import 'package:equifax_app/main.dart' as app;

void main() {
  // This line enables the extension.

  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with

  // any widget you are interested in testing.

  app.main();
}
