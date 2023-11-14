import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Each screen should have it's own screen file where screen
// Elements are defined. This increases readability of test files.
// This should also house any screen specific functions.

class Settingsscreen {
  // You can define common Finders/variables and use them to locate widgets from the test suite
  // We can hook into the elements in various ways, which can be
  // found by going to the widget inspector and clicking on
  // the button in the tree, which will show where in the code
  // it is defined

  // Elements
  Finder firebaseMessagingToken =
      find.byKey(const Key('firebaseMessagingToken'));

  Finder generalError = find.text(
    'An error occured. Please try again.',
  );
}
