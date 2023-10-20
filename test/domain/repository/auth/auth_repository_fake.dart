import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';

/// A fake implementation of the [AuthRepository]. This allows us to test the [LogInUseCase] without,
/// having to worry about the network (if one were to be used). Feel free to make any changes to
/// fit your needs.
class AuthRepositoryFake extends AuthRepository {
  Future<RequestResponse<UserInfo, LoginError>> response =
      Future.value(const Success(UserInfo(name: "", email: "")));

  void changeResponse(Future<RequestResponse<UserInfo, LoginError>> response) {
    this.response = response;
  }

  @override
  Future<RequestResponse<UserInfo, LoginError>> logIn(
      LoginInformation loginInformation) {
    return response;
  }
}
