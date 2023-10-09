import 'package:flap_app/presentation/screens/home/view/home_screen.dart';
import 'package:flap_app/presentation/screens/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Configuration for GoRouter, a library used for advance navigation
final GoRouter navigationRouter = GoRouter(
  initialLocation: '/',
  routes: [
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
