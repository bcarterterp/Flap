import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var flavorConfigProvider = StateProvider(
  (ref) => FlavorConfig(appTitle: "Staging"),
);

void mainCommon() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final config = context.read(flavorConfigProvider);
    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return MaterialApp(
      title: config.state.appTitle,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      home: MaterialApp.router(routerConfig: navigationRouter),
    );
  }
}