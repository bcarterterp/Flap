import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlavorConfig(name: "dev", location: BannerLocation.topEnd, variables: {
    "appTitle": "Boiler Plate - Dev Flavor",
    "baseUrl": "https://www.dev.example.com" //replace this baseUrl with the baseUrl used for your staging API
  });
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return FlavorBanner(
      child: MaterialApp(
        title: FlavorConfig.instance.variables["appTitle"],
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        home: MaterialApp.router(routerConfig: navigationRouter),
      ),
    );
  }
}
