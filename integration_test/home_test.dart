import 'package:flap_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/screens/home_screen.dart';

void main() {
  // This line is required for testing on web browsers
  // TODO: Explore browser testing
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Define screen for more readable code
  final homeScreen = HomeScreen();
  group('Home Integration Tests', () {
    testWidgets('test page elements', (tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Assertions below
      expect(homeScreen.title, findsOneWidget);
      expect(homeScreen.loginButton, findsOneWidget);
      expect(homeScreen.emailField, findsOneWidget);
      expect(homeScreen.passwordField, findsOneWidget);
    });

    testWidgets('test login error display', (tester) async {
      // Note: performs the same validation as the widget test
      // example difference being that these tests involve
      // launching the app on an emulator for validation

      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Verify no errors present at first
      expect(homeScreen.emailEmptyError, findsNothing);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsNothing);
      expect(homeScreen.passwordCheckError, findsNothing);

      // First trigger error state by clicking login
      await tester.tap(homeScreen.loginButton);
      // pumpAndSettle is used in this case to wait for loading
      // animation to be complete in between login button taps
      await tester.pumpAndSettle();
      // Test and make sure email empty error state is loaded
      expect(homeScreen.emailEmptyError, findsOneWidget);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsNothing);
      expect(homeScreen.passwordCheckError, findsNothing);

      // Enter text into email field then trigger password empty error
      await tester.enterText(homeScreen.emailField, "test@test.com");
      await tester.tap(homeScreen.loginButton);
      await tester.pumpAndSettle();
      expect(homeScreen.emailEmptyError, findsNothing);
      expect(homeScreen.emailCheckError, findsNothing);
      expect(homeScreen.passwordEmptyError, findsOneWidget);
      expect(homeScreen.passwordCheckError, findsNothing);

      // Enter text into password field then hit login
      await tester.enterText(homeScreen.passwordField, "test@test.com");
      await tester.tap(homeScreen.loginButton);
      await tester.pumpAndSettle();
      // Assert new error message is present
      expect(homeScreen.emailCheckError, findsOneWidget);
      expect(homeScreen.passwordCheckError, findsOneWidget);
      // Note: In general, it is better to use lightweight, focused widget tests
      // to ensure error scenarios are triggering when expected, rather than
      // a full scale end2end integration test, which will presumably
      // navigate through multiple screens to test an entire flow.
    });
  });
}
