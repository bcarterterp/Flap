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

    //Step 1:
    //Check if user has a JWT token and already signed in once.
    final jwtToken = await ref.read(secureStorageProvider).readJwt();
    if (jwtToken is SuccessRequestResponse) {
      // If JWt token is available, user is authenticated and update this in the app initialization user info data
      state = SplashScreenState.success(
        const AppInitializationInfo(isUserAuthenticated: true),
      );
      //If user is already authenticated, exit from this method
      return;
    }

    //Step 2:
    //Check if user has already launched this app before.
    final isFirstAppLaunch =
        await ref.read(sharedPrefRepositoryProvider).isFirstAppLaunch();
    if (isFirstAppLaunch) {
      //If this is the first time the app is launched, store this information in the AppInitializationInfo
      state = SplashScreenState.success(
        const AppInitializationInfo(isFirstTimeAppLaunch: true),
      );
      //Exit from this method if this is the first app launch
      return;
    } else {
      //Step 3:
      //If this is not the first app launch and user is not authenticated, store both values in the App InitializationInfo
      state = SplashScreenState.success(const AppInitializationInfo(
          isUserAuthenticated: false, isFirstTimeAppLaunch: false));
    }
  }
}
