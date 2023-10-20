import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/domain/usecase/log_in_usecase_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl();
}

@riverpod
LogInUseCase logInUseCase(LogInUseCaseRef ref) {
  return LogInUseCaseImpl(
    authRepository: ref.watch(authRepositoryProvider),
  );
}
