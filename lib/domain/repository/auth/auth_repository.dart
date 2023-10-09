import 'package:flap_app/domain/entity/login_error.dart';
import 'package:flap_app/domain/entity/login_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_info.dart';

abstract class AuthRepository {
  Future<RequestResponse<UserInfo, LoginError>> logIn(
      LoginInformation loginInformation);
}
