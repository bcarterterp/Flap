import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';

class CreditChartState extends Equatable {
  const CreditChartState({
    required this.viewData,
  });

  final Event<CreditChartData, CreditError> viewData;

  factory CreditChartState.initial() => CreditChartState(
        viewData: InitialEvent(),
      );

  factory CreditChartState.loading() => CreditChartState(
        viewData: LoadingEvent(),
      );

  factory CreditChartState.success(CreditChartData data) => CreditChartState(
        viewData: SuccessEvent(data),
      );

  factory CreditChartState.error(CreditError error) => CreditChartState(
        viewData: EventError(error),
      );

  @override
  List<Object?> get props => [viewData];
}
