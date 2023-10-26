import 'package:flap_app/presentation/screens/login/notifier/login_screen_state.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state_notifier.dart';

/// Fake notifier to swap in for testing the LoginScreen widget. Feel free to
/// add more methods to this class as needed.
class LoginScreenNotifierFake extends LoginScreenNotifier {
  LoginScreenState response = LoginScreenState.initial();

  void changeResponse(LoginScreenState response) {
    this.response = response;
  }

  @override
  Future<void> login(String email, String password) async {
    state = response;
    return;
  }
}
