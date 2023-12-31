import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/storage_error.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flap_app/domain/entity/request_response.dart';

import '../../../../domain/repository/secure_storage/secure_storage_fake.dart';
import '../../../../domain/usecase/log_in_usecase_fake.dart';
import '../../../../util/listener.dart';
import '../../../../util/provider_container.dart';

void main() {
  final loginUseCase = LoginUseCaseFake();
  final secureStorageFake = SecureStorageFake();

  group("LoginStateNotifier Unit Tests", () {
    test(
      "Given initial loginScreenStateNotifier, with no actions taken, then LoginScreenState should be initial.",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        final initialState = container.read(loginScreenNotifierProvider);
        expect(initialState, LoginScreenState.initial());
      },
    );

    test(
      "Given inital loginScreenStateNotifier, with login called and LoginError.emptyEmail returned, then loading and emptyEmail error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response =
            ErrorRequestResponse<UserInfo, LoginError>(LoginError.emptyEmail);
        loginUseCase.changeResponse(Future.value(response));
        final stateListener = Listener<LoginScreenState>();
        container.listen(
          loginScreenNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(loginScreenNotifierProvider.notifier)
            .login("email", "password");

        final states = stateListener.data;
        expect(states[0].value, LoginScreenState.loading());
        expect(states[1].value, LoginScreenState.error(LoginError.emptyEmail));
      },
    );

    test(
      "Given initial loginScreenStateNotifier, with login called and LoginError.emptyPassword returned, then loading and emptyPassword error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response = ErrorRequestResponse<UserInfo, LoginError>(
            LoginError.emptyPassword);
        loginUseCase.changeResponse(Future.value(response));
        final stateListener = Listener<LoginScreenState>();
        container.listen(
          loginScreenNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(loginScreenNotifierProvider.notifier)
            .login("email", "password");

        final states = stateListener.data;
        expect(states[0].value, LoginScreenState.loading());
        expect(
            states[1].value, LoginScreenState.error(LoginError.emptyPassword));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.incorrectEmailOrPassword returned, then loading and invalidEmailOrPassword error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response = ErrorRequestResponse<UserInfo, LoginError>(
            LoginError.incorrectEmailOrPassword);
        loginUseCase.changeResponse(Future.value(response));
        final stateListener = Listener<LoginScreenState>();
        container.listen(
          loginScreenNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(loginScreenNotifierProvider.notifier)
            .login("email", "password");

        final states = stateListener.data;
        expect(states[0].value, LoginScreenState.loading());
        expect(states[1].value,
            LoginScreenState.error(LoginError.incorrectEmailOrPassword));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.incorrectEmailOrPassword returned, then loading and successful states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
            secureStorageProvider.overrideWith((ref) => secureStorageFake)
          ],
        );
        const userInfo = UserInfo(
          name: "test",
          email: "test@testing.com",
          jwtToken: "example_token",
        );
        const response = SuccessRequestResponse<UserInfo, LoginError>(userInfo);
        loginUseCase.changeResponse(Future.value(response));

        const storageResponse =
            SuccessRequestResponse<String, StorageError>('Success');
        secureStorageFake.changeWriteResponse(Future.value(storageResponse));

        final stateListener = Listener<LoginScreenState>();
        container.listen(
          loginScreenNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(loginScreenNotifierProvider.notifier)
            .login("email", "password");

        final states = stateListener.data;
        expect(states[0].value, LoginScreenState.loading());
        expect(states[1].value, LoginScreenState.success(userInfo));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.jwtSaveUnsuccessful returned, then loading and error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
            secureStorageProvider.overrideWith((ref) => secureStorageFake)
          ],
        );

        const response = SuccessRequestResponse<UserInfo, LoginError>(
            UserInfo(name: "name", email: "email", jwtToken: "jwtToken"));
        loginUseCase.changeResponse(Future.value(response));

        const storageResponse =
            ErrorRequestResponse<String, StorageError>(StorageError.writeError);
        secureStorageFake.changeWriteResponse(Future.value(storageResponse));

        final stateListener = Listener<LoginScreenState>();
        container.listen(
          loginScreenNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(loginScreenNotifierProvider.notifier)
            .login("email", "password");

        final states = stateListener.data;
        expect(states[0].value, LoginScreenState.loading());
        expect(states[1].value,
            LoginScreenState.error(LoginError.jwtSaveUnsuccessful));
      },
    );
  });
}
