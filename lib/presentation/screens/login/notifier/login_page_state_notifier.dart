import 'package:equifax_app/domain/entity/login_info.dart';
import 'package:equifax_app/domain/repository/auth/auth_repository.dart';
import 'package:equifax_app/presentation/screens/login/notifier/login_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageStateNotifier extends StateNotifier<LoginPageState> {
  LoginPageStateNotifier({
    required AuthRepositoy authRepository,
  })  : _authRepository = authRepository,
        super(LoginPageState.initial());

  final AuthRepositoy _authRepository;

  /// Login with the given [email] and [password].
  Future<void> login(String email, String password) async {
    if (state.loginEvent.isLoading) {
      return;
    }

    state = LoginPageState.loading();

    final response = await _authRepository.login(
      LoginInformation(
        email: email,
        password: password,
      ),
    );

    if (response.isSuccess) {
      //We are using ! here because we know that the response is success,
      //this data has been set. Another option would be to use ?? and pass
      //in a default value.
      state = LoginPageState.success(response.data!);
    } else {
      state = LoginPageState.error(response.error!);
    }
  }
}
