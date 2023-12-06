import 'package:flap_app/domain/entity/app_initialization_info.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/presentation/screens/splash/notifier/splash_screen_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  //Need to figure out if jwt token is available

  @override
  ConsumerState<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  //init to initialize dependencies
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await (ref.read(splashScreenStateNotifierProvider.notifier))
          .initDependencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(splashScreenNotifierProvider).splashScreenEvent;
    final state =
        ref.watch(splashScreenStateNotifierProvider).splashScreenEvent;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is SuccessEvent) {
        final appInitializationInfo =
            (state as SuccessEvent).data as AppInitializationInfo;
        if (appInitializationInfo.getIsUserAuthenticated()) {
            context.go('/home');
        } else if (appInitializationInfo.getIsFirstTimeAppLaunch()) {
          context.go('/onboard');
        } else {
          context.go('/login');
        }
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
