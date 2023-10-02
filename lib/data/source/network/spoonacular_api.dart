import 'package:equifax_app/domain/entity/recipe.dart';

abstract class SpoonacularApi {
  Future<List<Recipe>> getRandomRecipes();
}
