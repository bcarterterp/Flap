import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state.dart';
import 'package:flap_app/presentation/widgets/credit_score/notifier/credit_score_state_notifier.dart';

class CreditScoreStateNotifierFake extends CreditScoreStateNotifier {
  CreditScoreState response = CreditScoreState.initial();

  void changeResponse(CreditScoreState response) {
    this.response = response;
  }

  @override
  Future<void> getCreditScore() async {
    state = response;
    return;
  }
}
