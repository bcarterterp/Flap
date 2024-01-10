import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Onboarding Screen: Welcome First Time User!'),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(sharedPrefRepositoryProvider)
                    .updateFirstAppLaunch(false);
                context.go('/login');
              },
              child: const Text('Go to Login'),
            )
          ],
        ),
      ),
    );
  }
}