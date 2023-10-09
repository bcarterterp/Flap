import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final SpoonacularApi _spoonacularApi;

  RecipeRepositoryImpl({required SpoonacularApi api}) : _spoonacularApi = api;

  @override
  Future<List<Recipe>> getRandomRecipes() async {
    return await _spoonacularApi.getRandomRecipes();
  }
}
