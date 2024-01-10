import 'package:flap_app/data/repository/shared_pref/shared_pref_repository_impl.dart';
import 'package:flap_app/domain/entity/app_initialization_info.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/splash/notifier/splash_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_screen_state_notifier.g.dart';

@riverpod
class SplashScreenStateNotifier extends _$SplashScreenStateNotifier {
  late ProviderContainer _sharedPrefContainer;
  @override
  SplashScreenState build() => SplashScreenState.initial();

  Future<void> initDependencies() async {
    state = SplashScreenState.initial();
    //Initialize any app services below
    await ref.read(sharedPrefRepositoryProvider).init();
    //TODO: Initialize Firebase instance here, for example
    await getAppStartNavInfo();
  }

  Future<void> getAppStartNavInfo() async {
    //To decide where to navigate the user on app start, we need the below information
    final isUserAuthenticated = await isJwtTokenAvailable();
    if (isUserAuthenticated) {
      //Exit this method
      return;
    } else {
      await isFirstTimeAppLaunch();
    }
  }

  Future<bool> isJwtTokenAvailable() async {
    //Check if user has a JWT token and already signed in.
    final jwtToken = await ref.read(secureStorageProvider).readJwt();
    if (jwtToken is SuccessRequestResponse) {
      // If JWt token is available, user is authenticated and update this in the app initialization user info data
      state = SplashScreenState.success(
        const AppInitializationInfo(isUserAuthenticated: true),
      );
      return true;
    }
    return false;
  }

  Future<void> isFirstTimeAppLaunch() async {
    //Check if user has already launched this app before.
    final isFirstAppLaunch =
        ref.read(sharedPrefRepositoryProvider).isFirstAppLaunch();
    print("is first app launch $isFirstAppLaunch");
    if (isFirstAppLaunch) {
      //If this is the first time the app is launched, store this information in the AppInitializationInfo
      state = SplashScreenState.success(
        const AppInitializationInfo(isFirstTimeAppLaunch: true),
      );
    } else {
      //If this is not the first app launch and user is not authenticated, store both values in the App InitializationInfo
      state = SplashScreenState.success(const AppInitializationInfo(
          isUserAuthenticated: false, isFirstTimeAppLaunch: false));
    }
  }
}
