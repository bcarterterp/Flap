import 'package:equatable/equatable.dart';
import 'package:flap_app/domain/entity/app_initialization_error.dart';
import 'package:flap_app/domain/entity/app_initialization_info.dart';
import 'package:flap_app/domain/entity/event.dart';

class SplashScreenState extends Equatable {
  final Event<AppInitializationInfo, AppInitializationError> splashScreenEvent;

  const SplashScreenState({required this.splashScreenEvent});

  factory SplashScreenState.initial() => SplashScreenState(
        splashScreenEvent: InitialEvent(),
      );

  factory SplashScreenState.loading() => SplashScreenState(
        splashScreenEvent: LoadingEvent(),
      );

  factory SplashScreenState.success(
          AppInitializationInfo appInitializationInfo) =>
      SplashScreenState(
        splashScreenEvent: SuccessEvent(appInitializationInfo),
      );

  factory SplashScreenState.error(AppInitializationError error) =>
      SplashScreenState(
        splashScreenEvent: EventError(error),
      );

  @override
  List<Object?> get props => [splashScreenEvent];
}
