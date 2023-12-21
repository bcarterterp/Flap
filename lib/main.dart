import 'package:flap_app/presentation/flap_app.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main(List<String> arguments) async {
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  runApp(const ProviderScope(child: FlapApp()));
}
