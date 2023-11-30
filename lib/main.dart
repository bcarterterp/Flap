import 'package:flap_app/presentation/my_app.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(List<String> arguments) {
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
  runApp(const ProviderScope(child: MyApp()));
}
