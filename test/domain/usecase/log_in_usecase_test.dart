import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../util/provider_container.dart';
import '../repository/auth/auth_repository_fake.dart';

main() {
  final authRepository = AuthRepositoryFake();
  group("Test the usage of LogInUseCase", () {
    test(
      "when successful response is sent back",
      () async {
        final container = createContainer(
          overrides: [
            authRepositoryProvider.overrideWith((ref) => authRepository),
          ],
        );
        const userInfo = UserInfo(name: "test", email: "test");
        authRepository.changeResponse(Future.value(const Success(userInfo)));
        final useCase = container.read(logInUseCaseProvider);
        final response = await useCase.logIn(
          const LoginInformation(
            email: "email",
            password: "password",
          ),
        );
        //Note: Must reinforce generic typing here because dart checks typing.
        expect(response, const Success<UserInfo, LoginError>(userInfo));
      },
    );

    test(
      "when blank email is sent",
      () async {
        final container = createContainer(
          overrides: [
            authRepositoryProvider.overrideWith((ref) => authRepository),
          ],
        );
        final useCase = container.read(logInUseCaseProvider);
        final response = await useCase.logIn(
          const LoginInformation(
            email: "",
            password: "password",
          ),
        );
        const expected = Error<UserInfo, LoginError>(LoginError.emptyEmail);
        expect(response, expected);
      },
    );

    test(
      "when blank password is sent",
      () async {
        final container = createContainer(
          overrides: [
            authRepositoryProvider.overrideWith((ref) => authRepository),
          ],
        );
        final useCase = container.read(logInUseCaseProvider);
        final response = await useCase.logIn(
          const LoginInformation(
            email: "email",
            password: "",
          ),
        );
        const expected = Error<UserInfo, LoginError>(LoginError.emptyPassword);
        expect(response, expected);
      },
    );
  });
}
