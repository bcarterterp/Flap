import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/event.dart';

class SettingsScreenState extends Equatable {
  const SettingsScreenState({required this.tokenLoadEvent});

  final Event<String, Exception> tokenLoadEvent;

  factory SettingsScreenState.initial() => SettingsScreenState(
        tokenLoadEvent: InitialEvent(),
      );

  factory SettingsScreenState.loading() => SettingsScreenState(
        tokenLoadEvent: LoadingEvent(),
      );

  factory SettingsScreenState.success(String firebaseMessagingToken) =>
      SettingsScreenState(
        tokenLoadEvent: SuccessEvent(firebaseMessagingToken),
      );

  factory SettingsScreenState.error(Exception error) => SettingsScreenState(
        tokenLoadEvent: EventError(error),
      );

  @override
  List<Object?> get props => [tokenLoadEvent];
}
