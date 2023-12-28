import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state.dart';
import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../domain/usecase/credit/credit_score_use_case_fake.dart';
import '../../../../util/listener.dart';
import '../../../../util/provider_container.dart';

void main() {
  final creditScoreUseCase = CreditScoreUseCaseFake();

  group("CreditChartStateNotifier Unit Tests", () {
    test(
      "Given initial creditScoreStateNotifier, with no actions taken, then CreditScoreState should be initial.",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        final initialState = container.read(creditScoreStateNotifierProvider);
        expect(initialState, CreditScoreState.initial());
      },
    );

    test(
      "Given inital creditScoreStateNotifier, with getCreditScore called and CreditError returned, then loading and error states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        const response = ErrorRequestResponse<UserCreditInfo, CreditError>(
            CreditError.currentCreditError);
        creditScoreUseCase.changeCurrentScoreResponse(response);
        final stateListener = Listener<CreditScoreState>();
        container.listen(
          creditScoreStateNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(creditScoreStateNotifierProvider.notifier)
            .getCreditScore();

        final states = stateListener.data;
        expect(states[0].value, CreditScoreState.loading());
        expect(states[1].value,
            CreditScoreState.error(CreditError.currentCreditError));
      },
    );

    test(
      "Given inital creditScoreStateNotifier, with getCreditScore called and Success returned, then loading and Success states should be returned",
      () async {
        // DO NOT share ProviderContainers between tests.
        final container = createContainer(
          overrides: [
            creditScoreUseCaseProvider
                .overrideWith((ref) => creditScoreUseCase),
          ],
        );
        final useScoreData = UserCreditInfo(score: 100, scoreDifference: 0);
        final response =
            SuccessRequestResponse<UserCreditInfo, CreditError>(useScoreData);
        creditScoreUseCase.changeCurrentScoreResponse(response);
        final stateListener = Listener<CreditScoreState>();
        container.listen(
          creditScoreStateNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );
        await container
            .read(creditScoreStateNotifierProvider.notifier)
            .getCreditScore();

        final states = stateListener.data;
        expect(states[0].value, CreditScoreState.loading());
        expect(states[1].value, CreditScoreState.success(useScoreData));
      },
    );
  });
}
