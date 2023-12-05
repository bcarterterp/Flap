import 'package:flap_app/domain/entity/app_initialization_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/splash/notifier/splash_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_screen_state_notifier.g.dart';

@riverpod
class SplashScreenStateNotifier extends _$SplashScreenStateNotifier {
  @override
  SplashScreenState build() => SplashScreenState.initial();

  Future<void> initDependencies() async {
    state = SplashScreenState.initial();

    //Check if user has a JWT token (will this fail if provider is not ready?)
    final jwtToken = await ref.read(secureStorageProvider).readJwt();
    if (jwtToken is SuccessRequestResponse) {
      // If JWt token is available, user is authenticated and update this in the app initialization user info data
      state = SplashScreenState.success(
        const AppInitializationInfo(isUserAuthenticated: true),
      );
      return;
    }

    //Check if user is first time app launch

    ref.read(sharedPrefRepositoryProvider).init();

    state = SplashScreenState.success(const AppInitializationInfo(
        isUserAuthenticated: false, isFirstTimeAppLaunch: false));
  }
}
