import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';

class CreditScoreState extends Equatable {
  const CreditScoreState({
    required this.viewData,
  });

  final Event<UserCreditInfo, CreditError> viewData;

  factory CreditScoreState.initial() => CreditScoreState(
        viewData: InitialEvent(),
      );

  factory CreditScoreState.loading() => CreditScoreState(
        viewData: LoadingEvent(),
      );

  factory CreditScoreState.success(UserCreditInfo data) => CreditScoreState(
        viewData: SuccessEvent(data),
      );

  factory CreditScoreState.error(CreditError error) => CreditScoreState(
        viewData: EventError(error),
      );

  @override
  List<Object?> get props => [viewData];
}
