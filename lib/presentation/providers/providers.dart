import 'package:equifax_app/data/repository/auth/auth_repository_impl.dart';
import 'package:equifax_app/domain/repository/auth/auth_repository.dart';
import 'package:equifax_app/presentation/screens/login/notifier/login_page_state.dart';
import 'package:equifax_app/presentation/screens/login/notifier/login_page_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepositoy>(
  (ref) => AuthRepositoyImpl(),
);

final loginPageStateProvider =
    StateNotifierProvider<LoginPageStateNotifier, LoginPageState>(
  (ref) => LoginPageStateNotifier(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
