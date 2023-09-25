import 'package:equifax_app/domain/entity/event.dart';
import 'package:equifax_app/domain/entity/login_error.dart';
import 'package:equifax_app/domain/entity/user_info.dart';

/// Class to hold the state of the login page.
class LoginPageState {
  LoginPageState({
    required this.loginEvent,
    this.emailError,
    this.passwordError,
  });

  factory LoginPageState.initial() => LoginPageState(
        loginEvent: Event.initial(),
      );

  factory LoginPageState.loading() => LoginPageState(
        loginEvent: Event.loading(),
      );

  factory LoginPageState.success(UserInfo userInfo) => LoginPageState(
        loginEvent: Event.success(userInfo),
      );

  factory LoginPageState.error(LoginError error) => _onError(error);

  final Event<UserInfo, LoginError> loginEvent;
  final String? emailError;
  final String? passwordError;

  LoginPageState copyWith({
    Event<UserInfo, LoginError>? loginEvent,
    String? emailError,
    String? passwordError,
  }) {
    return LoginPageState(
      loginEvent: loginEvent ?? this.loginEvent,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  static LoginPageState _onError(LoginError error) {
    switch (error) {
      case LoginError.emptyEmail:
        return LoginPageState(
          loginEvent: Event.error(error),
          emailError: 'Email is empty',
        );
      case LoginError.emptyPassword:
        return LoginPageState(
          loginEvent: Event.error(error),
          passwordError: 'Password is empty',
        );
      case LoginError.incorrectEmailOrPassword:
        return LoginPageState(
          loginEvent: Event.error(error),
          emailError: 'Check your email',
          passwordError: 'Check your password',
        );
    }
  }
}
