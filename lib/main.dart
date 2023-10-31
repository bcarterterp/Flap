import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Boilerplate',
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        home: MaterialApp.router(routerConfig: navigationRouter),
      ),
    );
  }
}
