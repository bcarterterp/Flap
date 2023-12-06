import 'package:dio/dio.dart';
import 'package:flap_app/data/repository/analytics/analytics_platform_manager.dart';
import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/data/repository/secure_storage/secure_storage_impl.dart';
import 'package:flap_app/data/source/network/mock/file_finder.dart';
import 'package:flap_app/data/source/network/mock/mockinterceptor.dart';
import 'package:flap_app/data/source/network/mock/spoonacular_file_finder.dart';
import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/data/source/network/spoonacular_api_impl.dart';
import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository_impl.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository.dart';
import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository_impl.dart';
import 'package:flap_app/domain/repository/storage/storage_service.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/domain/usecase/log_in_usecase_impl.dart';
import 'package:flap_app/presentation/flap_app_state.dart';
import 'package:flap_app/presentation/flap_app_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

final flavorRepositoryProvider = Provider<FlavorRepository>(
  (ref) => FlavorRepositoryImpl(),
);

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

@riverpod
List<FileFinder> mockFileFinders(MockFileFindersRef ref) {
  //Add your file finders here.
  return [
    SpoonacularFileFinder(),
  ];
}

@riverpod
MockInterceptor mockInterceptor(MockInterceptorRef ref) {
  return MockInterceptor(fileFinders: ref.watch(mockFileFindersProvider));
}

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  final flavorRepository = ref.watch(flavorRepositoryProvider);
  if (flavorRepository.shouldMockEndpoints()) {
    dio.interceptors.add(ref.watch(mockInterceptorProvider));
  }
  return dio;
}

@riverpod
SpoonacularApi spoonacularApi(SpoonacularApiRef ref) {
  return SpoonacularApiImpl(
      dio: ref.watch(dioProvider),
      flavorRepo: ref.watch(flavorRepositoryProvider));
}

@riverpod
RecipeRepository recipeRepository(RecipeRepositoryRef ref) {
  return RecipeRepositoryImpl(api: ref.watch(spoonacularApiProvider));
}

@riverpod
List<AnalyticsPlatform> analyticsPlatforms(AnalyticsPlatformsRef ref) {
  //Add your analytics platforms here
  return [];
}

final appStateProvider =
    StateNotifierProvider.autoDispose<AppStateNotifier, AppState>(
  (ref) => AppStateNotifier(
    sharedPrefRepository: ref.watch(sharedPrefRepositoryProvider),
  ),
);

@riverpod
AnalyticsPlatformManager analyticsPlatformManager(
    AnalyticsPlatformManagerRef ref) {
  return AnalyticsPlatformManager(
    analyticsPlatforms: ref.watch(
      analyticsPlatformsProvider,
    ),
  );
}

@riverpod
StorageService secureStorage(SecureStorageRef ref) {
  return SecureStorageImpl();
}

@riverpod
SharedPrefRepository sharedPrefRepository(SharedPrefRepositoryRef ref) {
  return SharedPrefRepositoryImpl();
}
