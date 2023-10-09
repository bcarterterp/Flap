import 'package:flap_app/domain/entity/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRandomRecipes();
}
