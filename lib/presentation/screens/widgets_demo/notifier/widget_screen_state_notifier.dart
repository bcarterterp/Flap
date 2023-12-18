import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/widgets_demo/notifier/widget_screen_state.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget_screen_state_notifier.g.dart';

@riverpod
class WidgetScreenStateNotifier extends _$WidgetScreenStateNotifier {
  @override
  WidgetScreenState build() => WidgetScreenState.initial();

  Future<void> getCurrentScore() async {
    if (state.viewData is LoadingEvent) {
      return;
    }

    state = WidgetScreenState.loading();

    final response =
        await ref.read(creditScoreUseCaseProvider).getCurrentScore();

    switch (response) {
      case SuccessRequestResponse<UserCreditInfo, CreditError>():
        state = WidgetScreenState.success();
      case ErrorRequestResponse<UserCreditInfo, CreditError>():
        state = WidgetScreenState.error(response.error);
    }
  }

  Future<void> getCreditHistoryChartData(
      Period period, double goal, DateTime currentDate) async {
    if (state.viewData is LoadingEvent) {
      return;
    }

    state = WidgetScreenState.loading();

    final response = await ref
        .read(creditScoreUseCaseProvider)
        .getCreditHistoryChartData(period, goal, currentDate);

    switch (response) {
      case SuccessRequestResponse<CreditChartData, CreditError>():
        state = WidgetScreenState.success();
      case ErrorRequestResponse<CreditChartData, CreditError>():
        state = WidgetScreenState.error(response.error);
    }
  }
}
