import 'package:equifax_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generic log in screen with email and password fields.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please Enter Credentials',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              const LoginInformationWiget(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget that contains the email and password fields, and the submit button.
/// Broken out to reduce the amount of widgets that will be refreshed when there
/// is a state change.
class LoginInformationWiget extends ConsumerStatefulWidget {
  const LoginInformationWiget({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginInformationWiget> createState() {
    return _LoginInformationWigetState();
  }
}

class _LoginInformationWigetState extends ConsumerState<LoginInformationWiget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    final email = emailController.text;
    final password = passwordController.text;
    ref.read(loginPageStateProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginPageStateProvider);

    ElevatedButton button = ElevatedButton(
      onPressed: login,
      child: const Text('Login'),
    );
    if (loginState.loginEvent.isLoading) {
      button = const ElevatedButton(
        onPressed: null,
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Email',
            errorText: loginState.emailError,
          ),
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
        ),
        const SizedBox(
          height: 4,
        ),
        TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            errorText: loginState.passwordError,
          ),
          obscureText: true,
          controller: passwordController,
        ),
        const SizedBox(
          height: 8,
        ),
        button
      ],
    );
  }
}
