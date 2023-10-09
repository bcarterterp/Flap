import 'package:flutter_driver/flutter_driver.dart';
import 'base_screen.dart';

// Each screen should have it's own screen file where screen
// Elements are defined. This increases readability of test files.
// This should also house any screen specific functions.

class HomeScreen extends BaseScreen {
  // Constructor
  HomeScreen(super.driver);
  // You can define common Finders/variables and use them to locate widgets from the test suite
  // We can hook into the elements in various ways, which can be
  // found by going to the widget inspector and clicking on
  // the button in the tree, which will show where in the code
  // it is defined

  // Elements
  SerializableFinder title = find.text("Please Enter Credentials");
  final emailField = find.byValueKey('emailTextField');
  final passwordField = find.byValueKey('passwordTextField');
  SerializableFinder loginButton = find.text("Login");

  // Error texts
  SerializableFinder emailEmptyError = find.text('Email is empty');
  SerializableFinder passwordEmptyError = find.text('Password is empty');

  SerializableFinder emailCheckError = find.text('Check your email');
  SerializableFinder passwordCheckError = find.text('Check your password');
}
