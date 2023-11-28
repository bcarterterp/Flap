import 'dart:async';

import 'package:flap_app/my_app.dart';
import 'package:flap_app/util/flavor/flavor.dart';
import 'package:flap_app/util/flavor/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureOr<void> main(List<String> arguments) async {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  if (flavor == "prod") {
    FlavorConfig.flavor = Flavor.prod;
  } else {
    FlavorConfig.flavor = Flavor.dev;
  }
  // ProviderScope is what makes Riverpod work.
  runApp(const ProviderScope(child: MyApp()));
}
