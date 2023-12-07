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
            const Text('Onboarding Screen'),
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

//   final PageController _pageController = PageController(initialPage: 0);

//   final List<Widget> onboardingScreens = [
//   OnboardingPage(
//     title: 'Welcome to App',
//     description: 'This is an awesome app!',
//     imagePath: 'images/onboarding_page_1.png',
//   ),
//   // Add more OnboardingPage widgets as per your requirement
// ];
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         PageView(
//           controller: _pageController,
//           children: onboardingScreens,
//         ),
//       ],
//     );
//   }
// }

// class OnboardingPage{
//   final String title, description, imagePath;
//   Onboard({
//     required this.title,
//   });
// }
