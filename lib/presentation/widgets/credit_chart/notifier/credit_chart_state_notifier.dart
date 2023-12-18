import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';
import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_chart_state_notifier.g.dart';

@riverpod
class CreditChartStateNotifier extends _$CreditChartStateNotifier {
  @override
  CreditChartState build() => CreditChartState.initial();

  Future<void> getChartData(
      Period period, double goal, DateTime currentDate) async {
    if (state.viewData is LoadingEvent) {
      return;
    }

    state = CreditChartState.loading();

    final response = await ref
        .read(creditScoreUseCaseProvider)
        .getCreditHistoryChartData(period, goal, currentDate);

    switch (response) {
      case SuccessRequestResponse<CreditChartData, CreditError>():
        state = CreditChartState.success(response.data);
      case ErrorRequestResponse<CreditChartData, CreditError>():
        state = CreditChartState.error(response.error);
    }
  }
}
