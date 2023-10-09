import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
// Each screen should have it's own screen file where screen
// Elements are defined. This increases readability of test files.
// This should also house any screen specific functions.

class HomeScreen {
  // You can define common Finders/variables and use them to locate widgets from the test suite
  // We can hook into the elements in various ways, which can be
  // found by going to the widget inspector and clicking on
  // the button in the tree, which will show where in the code
  // it is defined

  // Elements
  Finder loginButton = find.text("Login");
  Finder emailField = find.byKey(const Key('emailTextField'));
  Finder passwordField = find.byKey(const Key('passwordTextField'));
  // Error texts
  Finder emailEmptyError = find.textContaining('Email is empty');
  Finder passwordEmptyError = find.text('Password is empty');

  Finder emailCheckError = find.text('Check your email');
  Finder passwordCheckError = find.text('Check your password');
}
