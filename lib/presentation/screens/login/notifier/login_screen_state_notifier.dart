import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageStateNotifier extends StateNotifier<LoginScreenState> {
  LoginPageStateNotifier({
    required LogInUseCase logInUseCase,
  })  : _logInUseCase = logInUseCase,
        super(LoginScreenState.initial());

  final LogInUseCase _logInUseCase;

  /// Login with the given [email] and [password].
  Future<void> login(String email, String password) async {
    if (state is LoadingEvent) {
      return;
    }

    state = LoginScreenState.loading();

    final response = await _logInUseCase.logIn(
      LoginInformation(
        email: email,
        password: password,
      ),
    );

    switch (response) {
      case Loading<UserInfo, LoginError>():
        state = LoginScreenState.loading();
      case Success<UserInfo, LoginError>():
        state = LoginScreenState.success(response.data);
      case Error<UserInfo, LoginError>():
        state = LoginScreenState.error(response.error);
    }
  }
}
