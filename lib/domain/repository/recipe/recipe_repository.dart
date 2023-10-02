import 'package:equifax_app/domain/entity/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRandomRecipes();
}
