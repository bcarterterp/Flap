import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'credit_score_state_notifier.g.dart';

@riverpod
class CreditScoreStateNotifier extends _$CreditScoreStateNotifier {
  @override
  CreditScoreState build() => CreditScoreState.initial();

  Future<void> getCreditScore() async {
    if (state.viewData is LoadingEvent) {
      return;
    }

    state = CreditScoreState.loading();

    final response =
        await ref.read(creditScoreUseCaseProvider).getCurrentScore();

    switch (response) {
      case SuccessRequestResponse<UserCreditInfo, CreditError>():
        state = CreditScoreState.success(response.data);
      case ErrorRequestResponse<UserCreditInfo, CreditError>():
        state = CreditScoreState.error(response.error);
    }
  }
}
