import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';

abstract class CreditScoreRepository {
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore();

  Future<RequestResponse<UserCreditHistory, CreditError>> getCreditHistory();
}
