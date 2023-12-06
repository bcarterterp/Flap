import 'package:flap_app/presentation/screens/home/view/home_screen.dart';
import 'package:flap_app/presentation/screens/login/view/login_screen.dart';
import 'package:flap_app/presentation/screens/onboard/view/onboarding_screen.dart';
import 'package:flap_app/presentation/screens/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//Navigation routes are defined in the below GoRouter configuration

final GoRouter navigationRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: 'onboard',
      path: '/onboard',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
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
