import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_app.dart';

FutureOr<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
}
