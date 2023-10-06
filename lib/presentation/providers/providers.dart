import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_page_state.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_page_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepositoy>(
  (ref) => AuthRepositoyImpl(),
);

final logInUseCaseProvider = Provider<LogInUseCase>(
  (ref) => LogInUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final loginPageStateProvider =
    StateNotifierProvider<LoginPageStateNotifier, LoginScreenState>(
  (ref) => LoginPageStateNotifier(
    logInUseCase: ref.watch(logInUseCaseProvider),
  ),
);
