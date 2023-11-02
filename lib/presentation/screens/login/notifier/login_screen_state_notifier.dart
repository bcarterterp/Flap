import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/storage_error.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_screen_state_notifier.g.dart';

@riverpod
class LoginScreenNotifier extends _$LoginScreenNotifier {
  @override
  LoginScreenState build() => LoginScreenState.initial();

  /// Login with the given [email] and [password].
  Future<void> login(String email, String password) async {
    if (state.loginEvent is LoadingEvent) {
      return;
    }

    state = LoginScreenState.loading();

    final response = await ref.read(logInUseCaseProvider).logIn(
          LoginInformation(
            email: email,
            password: password,
          ),
        );

    switch (response) {
      case SuccessRequestResponse<UserInfo, LoginError>():
        final jwtSaveSuccessful = await _saveJwt(response.data.jwtToken);

        if (jwtSaveSuccessful) {
          state = LoginScreenState.success(response.data);
        } else {
          state = LoginScreenState.error(LoginError.jwtSaveUnsuccessful);
        }
      case ErrorRequestResponse<UserInfo, LoginError>():
        state = LoginScreenState.error(response.error);
    }
  }

  Future<bool> _saveJwt(String token) async {
    final saveToken =
        await ref.read(secureStorageServiceProvider).writeJwt(token);

    return saveToken is SuccessRequestResponse<String, StorageError>;
  }
}
