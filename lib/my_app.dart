import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return MaterialApp.router(
      title: (ref.read(flavorRepositoryProvider)).getAppTitle(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      routerConfig: navigationRouter,
    );
  }
}
