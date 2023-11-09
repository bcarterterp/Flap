import 'dart:async';

import 'package:flap_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureOr<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
}