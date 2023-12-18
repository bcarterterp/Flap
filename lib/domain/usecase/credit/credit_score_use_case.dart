import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';

abstract class CreditScoreUseCase {
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore();

  Future<RequestResponse<CreditChartData, CreditError>>
      getCreditHistoryChartData(
          Period period, double goal, DateTime currentDate);
}
