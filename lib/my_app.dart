import 'package:flap_app/presentation/app_state.dart';
import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/splash/view/splash_screen.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appStateProvider.notifier).initDependencies();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    const theme = AppTheme();
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    if (appState == AppState.success()) {
      return MaterialApp.router(
        title: (ref.read(flavorRepositoryProvider)).getAppTitle(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        routerConfig: navigationRouter,
      );
    } else {
      //what app is not in success state yet, display custom splash screen
      return const MaterialApp(home: SplashScreen());
    }
  }
}
