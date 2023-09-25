import 'package:equifax_app/presentation/screens/login/view/login_screen.dart';
import 'package:equifax_app/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const theme = AppTheme();
    // ProviderScope is what makes Riverpod work.
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Boilerplate',
        theme: theme.toThemeData(),
        darkTheme: theme.toThemeDataDark(),
        home: const LoginScreen(),
      ),
    );
  }
}
