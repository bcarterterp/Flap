import 'package:flap_app/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/presentation/screens/login/login_screen.dart';

void main() {
  // This line is required for testing on web browsers
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Define screen for more readable code
  final loginScreen = Loginscreen();
  group('Home Integration Tests', () {
    testWidgets('test page elements', (tester) async {
      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Assertions below
      expect(loginScreen.title, findsOneWidget);
      expect(loginScreen.loginButton, findsOneWidget);
      expect(loginScreen.emailField, findsOneWidget);
      expect(loginScreen.passwordField, findsOneWidget);
    });

    testWidgets('test login error display', (tester) async {
      // Note: performs the same validation as the widget test
      // example difference being that these tests involve
      // launching the app on an emulator for validation
      // Note: In general, it is better to use lightweight, focused widget tests
      // to ensure error scenarios are triggering when expected, rather than
      // a full scale end2end integration test, which will presumably
      // navigate through multiple screens to test an entire flow.

      // Causes test to wait for app to finish launch before testing
      await tester.pumpWidget(const MyApp());

      // Verify no errors present at first
      expect(loginScreen.emailEmptyError, findsNothing);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsNothing);
      expect(loginScreen.passwordCheckError, findsNothing);

      // First trigger error state by clicking login
      await tester.tap(loginScreen.loginButton);
      // pumpAndSettle is used in this case to wait for loading
      // animation to be complete in between login button taps
      await tester.pumpAndSettle();
      // Test and make sure email empty error state is loaded
      expect(loginScreen.emailEmptyError, findsOneWidget);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsNothing);
      expect(loginScreen.passwordCheckError, findsNothing);

      // Enter text into email field then trigger password empty error
      await tester.enterText(loginScreen.emailField, "test@test.com");
      await tester.tap(loginScreen.loginButton);
      await tester.pumpAndSettle();
      expect(loginScreen.emailEmptyError, findsNothing);
      expect(loginScreen.emailCheckError, findsNothing);
      expect(loginScreen.passwordEmptyError, findsOneWidget);
      expect(loginScreen.passwordCheckError, findsNothing);

      // Enter text into password field then hit login
      await tester.enterText(loginScreen.passwordField, "test@test.com");
      await tester.tap(loginScreen.loginButton);
      await tester.pumpAndSettle();
      // Assert new error message is present
      expect(loginScreen.emailCheckError, findsOneWidget);
      expect(loginScreen.passwordCheckError, findsOneWidget);
    });
  });
}
