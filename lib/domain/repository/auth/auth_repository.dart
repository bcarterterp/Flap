import 'package:equifax_app/domain/entity/login_error.dart';
import 'package:equifax_app/domain/entity/login_info.dart';
import 'package:equifax_app/domain/entity/request_response.dart';
import 'package:equifax_app/domain/entity/user_info.dart';

abstract class AuthRepositoy {
  Future<RequestResponse<UserInfo, LoginError>> login(LoginInformation loginInformation);
}