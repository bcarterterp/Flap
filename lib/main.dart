import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flap_app/firebase_options.dart';
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

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseMessaging = ref.watch(firebaseMessagingRepositoryProvider);

    firebaseMessaging.init();

    firebaseMessaging.hasAcceptedPermissions();

    firebaseMessaging.getToken().then((token) {
      if (token != null) {
        log("Firebase device token: $token");
      } else {
        log("No firebase token");
      }
    });

    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    // MaterialApp.router is what sets our routerConfig to our GoRouter object
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      home: MaterialApp.router(routerConfig: navigationRouter),
    );
  }
}
