import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state.dart';
import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state_notifier.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';

class CreditChartStateNotifierFake extends CreditChartStateNotifier {
  CreditChartState response = CreditChartState.initial();

  void changeResponse(CreditChartState response) {
    this.response = response;
  }

  @override
  Future<void> getChartData(
      Period period, double goal, DateTime currentDate) async {
    state = response;
    return;
  }
}
