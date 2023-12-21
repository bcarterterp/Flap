import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flap_app/firebase_options.dart';
import 'package:flap_app/presentation/flap_app.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> arguments) async {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  switch (flavor) {
    case 'prod':
      FlavorConfig.flavor = Flavor.prod;
      break;
    case 'mock':
      FlavorConfig.flavor = Flavor.mock;
      break;
    default:
      FlavorConfig.flavor = Flavor.dev;
      break;
  }
  initalizeFirebase();
  runApp(const ProviderScope(child: FlapApp()));
}

Future<void> initalizeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}
