import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';

/// A fake implementation of the [LogInUseCase]. This allows us to test the [LoginScreenNotifier] without
/// having to use [LogInUseCaseImpl] as a dependency. Feel free to make any changes to fit your needs.
class LoginUseCaseFake extends LogInUseCase {
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
