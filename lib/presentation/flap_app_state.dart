import '../domain/entity/event.dart';

class AppState {
  const AppState({required this.appEvent});

  final Event<String, Error> appEvent;

  factory AppState.initial() => AppState(appEvent: InitialEvent());

  factory AppState.loading() => AppState(appEvent: LoadingEvent());

  factory AppState.success() => const AppState(
        appEvent: SuccessEvent("Successful"),
      );

  factory AppState.error(String error) => AppState(
        appEvent: EventError(Error()),
      );
}