import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';

/// Fake implementation of Authentication and is used only as an example. This is where you would sub for
/// your own network implementation.
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<RequestResponse<UserInfo, LoginError>> logIn(
    LoginInformation loginInformation,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final email = loginInformation.email;
    final password = loginInformation.password;
    if (email == 'admin@testing.com' && password == 'admin') {
      return Future.value(SuccessRequestResponse(UserInfo(
        name: 'Admin',
        email: email,
      )));
    } else {
      return Future.value(ErrorRequestResponse(LoginError.incorrectEmailOrPassword));
    }
  }
}
