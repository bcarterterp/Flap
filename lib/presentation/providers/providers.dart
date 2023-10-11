import 'package:dio/dio.dart';
import 'package:flap_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flap_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/domain/repository/auth/auth_repository.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/domain/usecase/log_in_usecase.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_page_state.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_page_state_notifier.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_page_state.dart';
import 'package:flap_app/presentation/screens/login/notifier/login_page_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: Investigate dependency injection solutions for passing in Dio to api class
Dio dio = Dio();

final apiProvider =
    Provider<SpoonacularApi>((ref) => SpoonacularApiImpl(dio: dio));

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

final logInUseCaseProvider = Provider<LogInUseCase>(
  (ref) => LogInUseCase(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final recipeRepositoryProvider = Provider<RecipeRepository>(
  (ref) => RecipeRepositoryImpl(api: ref.read(apiProvider)),
);

final loginPageStateProvider =
    StateNotifierProvider<LoginPageStateNotifier, LoginScreenState>(
  (ref) => LoginPageStateNotifier(
    logInUseCase: ref.watch(logInUseCaseProvider),
  ),
);

final homePageStateProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>(
  (ref) => HomePageStateNotifier(
    recipeRepository: ref.watch(recipeRepositoryProvider),
  ),
);
