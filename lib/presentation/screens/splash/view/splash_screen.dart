import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//the below is a custom splash screen that displays a lottie animation
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Lottie.asset('assets/animations/flutter_color_spinner.json',
              width: 200, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
