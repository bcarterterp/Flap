import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flap_app/presentation/navigation.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStatNotifier = ref.watch(appStateProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      appStatNotifier.initDependencies();
    });

    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return MaterialApp.router(
      title: 'Flutter Boilerplate',
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      routerConfig: navigationRouter,
    );
  }
}
