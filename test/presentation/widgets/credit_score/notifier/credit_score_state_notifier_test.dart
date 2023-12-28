import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state.dart';
import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state_notifier.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../domain/usecase/credit/credit_score_use_case_fake.dart';
import '../../../../util/listener.dart';
import '../../../../util/provider_container.dart';

void main() {
  final creditScoreUseCase = CreditScoreUseCaseFake();

  group("CreditChartStateNotifier Unit Tests", () {
    test(
      "Given initial creditChartStateNotifier, with no actions taken, then CreditChartState should be initial.",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        final initialState = container.read(creditChartStateNotifierProvider);
        expect(initialState, CreditChartState.initial());
      },
    );

    test(
      "Given inital creditChartStateNotifier, with getChartData called and CreditError returned, then loading and error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        const response = ErrorRequestResponse<CreditChartData, CreditError>(
            CreditError.creditHistoryError);
        creditScoreUseCase.changeHistoryResponse(response);
        final stateListener = Listener<CreditChartState>();
        container.listen(
          creditChartStateNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(creditChartStateNotifierProvider.notifier)
            .getChartData(Period.past5Months, 700, DateTime.now());

        final states = stateListener.data;
        expect(states[0].value, CreditChartState.loading());
        expect(states[1].value,
            CreditChartState.error(CreditError.creditHistoryError));
      },
    );

    test(
      "Given inital creditChartStateNotifier, with getChartData called and Success returned, then loading and Success states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        const response = SuccessRequestResponse<CreditChartData, CreditError>(
            CreditChartData());
        creditScoreUseCase.changeHistoryResponse(response);
        final stateListener = Listener<CreditChartState>();
        container.listen(
          creditChartStateNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(creditChartStateNotifierProvider.notifier)
            .getChartData(Period.past5Months, 700, DateTime.now());

        final states = stateListener.data;
        expect(states[0].value, CreditChartState.loading());
        expect(
            states[1].value, CreditChartState.success(const CreditChartData()));
      },
    );
  });
}
