import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/domain/usecase/credit/credit_score_use_case.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';

class CreditScoreUseCaseFake extends CreditScoreUseCase {
  RequestResponse<CreditChartData, CreditError> historyResponse =
      const SuccessRequestResponse(CreditChartData());

  RequestResponse<UserCreditInfo, CreditError> currentScoreResponse =
      SuccessRequestResponse(UserCreditInfo(score: 100, scoreDifference: 0));

  void changeHistoryResponse(
      RequestResponse<CreditChartData, CreditError> response) {
    historyResponse = response;
  }

  void changeCurrentScoreResponse(
      RequestResponse<UserCreditInfo, CreditError> response) {
    currentScoreResponse = response;
  }

  @override
  Future<RequestResponse<CreditChartData, CreditError>>
      getCreditHistoryChartData(
          Period period, double goal, DateTime currentDate) {
    return Future.value(historyResponse);
  }

  @override
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore() {
    return Future.value(currentScoreResponse);
  }
}
