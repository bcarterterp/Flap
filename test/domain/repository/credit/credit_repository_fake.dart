import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/domain/repository/credit/credit_repository.dart';

class CreditRepositoryFake extends CreditScoreRepository {
  RequestResponse<UserCreditHistory, CreditError> historyResponse =
      SuccessRequestResponse(UserCreditHistory(data: []));

  RequestResponse<UserCreditInfo, CreditError> currentScoreResponse =
      SuccessRequestResponse(UserCreditInfo(score: 100, scoreDifference: 0));

  @override
  Future<RequestResponse<UserCreditHistory, CreditError>> getCreditHistory() {
    return Future.value(historyResponse);
  }

  void changeCreditHistoryResponse(
      RequestResponse<UserCreditHistory, CreditError> response) {
    historyResponse = response;
  }

  void changeCurrentScoreResponse(
      RequestResponse<UserCreditInfo, CreditError> response) {
    currentScoreResponse = response;
  }

  @override
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore() {
    return Future.value(currentScoreResponse);
  }
}
