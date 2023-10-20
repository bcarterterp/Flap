import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_page_state.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_screen_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flap_app/domain/entity/request_response.dart';

import '../../../../domain/usecase/log_in_usecase_fake.dart';
import '../../../../util/listener.dart';
import '../../../../util/provider_container.dart';

void main() {
  final loginUseCase = LoginUseCaseFake();

  group("Unit Tests surrounding LoginStateNotifier", () {
    test(
      "given loginScreenStateNotifier, with no actions taken, then initial state should be returned",
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
      "given loginScreenStateNotifier, with login called and LoginError.emptyEmail returned, then correct states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response = Error<UserInfo, LoginError>(LoginError.emptyEmail);
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
        expect(states[0].$2, LoginScreenState.loading());
        expect(states[1].$2, LoginScreenState.error(LoginError.emptyEmail));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.emptyPassword returned, then correct states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response = Error<UserInfo, LoginError>(LoginError.emptyPassword);
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
        expect(states[0].$2, LoginScreenState.loading());
        expect(states[1].$2, LoginScreenState.error(LoginError.emptyPassword));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.incorrectEmailOrPassword returned, then correct states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const response =
            Error<UserInfo, LoginError>(LoginError.incorrectEmailOrPassword);
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
        expect(states[0].$2, LoginScreenState.loading());
        expect(states[1].$2,
            LoginScreenState.error(LoginError.incorrectEmailOrPassword));
      },
    );

    test(
      "given loginScreenStateNotifier, with login called and LoginError.incorrectEmailOrPassword returned, then correct states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            logInUseCaseProvider.overrideWith((ref) => loginUseCase),
          ],
        );
        const userInfo = UserInfo(
          name: "test",
          email: "test@testing.com",
        );
        const response = Success<UserInfo, LoginError>(userInfo);
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
        expect(states[0].$2, LoginScreenState.loading());
        expect(states[1].$2, LoginScreenState.success(userInfo));
      },
    );
  });
}
