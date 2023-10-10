import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(HomePageState.initial());

  final RecipeRepository _recipeRepository;

  Future<void> getRandomRecipes() async {
    final _response = await _recipeRepository.getRandomRecipes();
    switch (_response) {
      case Success<List<Recipe>, DioException>():
        state = HomePageState.success(_response.data);
      case Error<List<Recipe>, DioException>():
        state = HomePageState.error(_response.error);
    }
  }
}
