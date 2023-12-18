import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';

class WidgetScreenState extends Equatable {
  const WidgetScreenState({
    required this.viewData,
  });

  final Event<String, CreditError> viewData;

  factory WidgetScreenState.initial() => WidgetScreenState(
        viewData: InitialEvent(),
      );

  factory WidgetScreenState.loading() => WidgetScreenState(
        viewData: LoadingEvent(),
      );

  factory WidgetScreenState.success() => const WidgetScreenState(
        viewData: SuccessEvent("Success"),
      );

  factory WidgetScreenState.error(CreditError error) => WidgetScreenState(
        viewData: EventError(error),
      );

  @override
  List<Object?> get props => [viewData];
}
