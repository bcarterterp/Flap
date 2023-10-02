import 'package:equifax_app/domain/repository/recipe/recipe_repository.dart';
import 'package:equifax_app/presentation/screens/home/notifier/home_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(const HomePageState());

  final RecipeRepository _recipeRepository;

  Future<void> getRandomRecipes() async {
    final _randomRecipes = await _recipeRepository.getRandomRecipes();
    state = state.copyWith(randomRecipes: _randomRecipes);
  }
}
