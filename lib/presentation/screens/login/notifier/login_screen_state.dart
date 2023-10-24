import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/user_info.dart';

/// Class to hold the state of the login page.
class LoginScreenState {
  LoginScreenState({
    required this.loginEvent,
    this.emailError,
    this.passwordError,
  });

  factory LoginScreenState.initial() => LoginScreenState(
        loginEvent: InitialEvent(),
      );

  factory LoginScreenState.loading() => LoginScreenState(
        loginEvent: LoadingEvent(),
      );

  factory LoginScreenState.success(UserInfo userInfo) => LoginScreenState(
        loginEvent: SuccessEvent(userInfo),
      );

  factory LoginScreenState.error(LoginError error) => _onError(error);

  final Event<UserInfo, LoginError> loginEvent;
  final String? emailError;
  final String? passwordError;

  LoginScreenState copyWith({
    Event<UserInfo, LoginError>? loginEvent,
    String? emailError,
    String? passwordError,
  }) {
    return LoginScreenState(
      loginEvent: loginEvent ?? this.loginEvent,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }

  static LoginScreenState _onError(LoginError error) {
    switch (error) {
      case LoginError.emptyEmail:
        return LoginScreenState(
          loginEvent: EventError(error),
          emailError: 'Email is empty',
        );
      case LoginError.emptyPassword:
        return LoginScreenState(
          loginEvent: EventError(error),
          passwordError: 'Password is empty',
        );
      case LoginError.incorrectEmailOrPassword:
        return LoginScreenState(
          loginEvent: EventError(error),
          emailError: 'Check your email',
          passwordError: 'Check your password',
        );
    }
  }
}
