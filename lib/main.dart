<<<<<<< HEAD
import 'package:equifax_app/presentation/screens/home/view/home_screen.dart';
import 'package:equifax_app/presentation/screens/login/view/login_screen.dart';
import 'package:equifax_app/presentation/theme/app_theme.dart';
||||||| e5fc1ed
import 'package:equifax_app/presentation/screens/login/view/login_screen.dart';
import 'package:equifax_app/presentation/theme/app_theme.dart';
=======
import 'package:flap_app/presentation/screens/login/view/login_screen.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
>>>>>>> main
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

// Configure GoRouter for navigation

final GoRouter _router = GoRouter(
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Boilerplate',
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        home: MaterialApp.router(routerConfig: _router),
      ),
    );
  }
}
