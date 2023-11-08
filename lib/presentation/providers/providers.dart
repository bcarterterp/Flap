import 'package:dio/dio.dart';
import 'package:flap_app/data/repository/analytics/analytics_platform_manager.dart';
import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/data/repository/secure_storage/secure_storage_impl.dart';
import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/data/source/network/spoonacular_api_impl.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository_impl.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/domain/repository/storage/storage_service.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/domain/usecase/log_in_usecase_impl.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref){
  return SharedPreferences.getInstance();
}

Dio dio = Dio();

final apiProvider =
    Provider<SpoonacularApi>((ref) => SpoonacularApiImpl(dio: dio, flavorRepo: ref.watch(flavorRepositoryProvider)));

final recipeRepositoryProvider = Provider<RecipeRepository>(
  (ref) => RecipeRepositoryImpl(api: ref.read(apiProvider)),
);

final homePageStateProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>(
  (ref) => HomePageStateNotifier(
    recipeRepository: ref.watch(recipeRepositoryProvider),
  ),
);

final recipeListProvider = Provider<List<Recipe>>((ref) {
  final state = ref.watch(homePageStateProvider);
  return (state.loadRecipesEvent as SuccessEvent<List<Recipe>, DioException>)
      .data; // Assuming the recipeList is stored in the data field of HomePageState class
});

final analyticsProvider = Provider<AnalyticsPlatformManager>(
  (ref) => AnalyticsPlatformManager(),
);

@riverpod
StorageService secureStorage(SecureStorageRef ref) {
  return SecureStorageImpl();
}
