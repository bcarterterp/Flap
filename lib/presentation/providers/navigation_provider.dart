import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/view/home_screen.dart';
import 'package:flap_app/presentation/screens/login/view/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'navigation_provider.g.dart';

@riverpod
Future<GoRouter> goRouter(GoRouterRef ref) async {
  final SharedPreferences sharedPrefs =
      await ref.watch(sharedPreferencesProvider as ProviderListenable<FutureOr<SharedPreferences>>);
  final bool? firstAppLaunch = sharedPrefs.getBool('firstAppLaunch');
  return GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      if (firstAppLaunch == null) {
        return '/splash';
      }
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'splash',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}
