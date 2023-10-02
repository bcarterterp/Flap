import 'package:dio/dio.dart';
import 'package:equifax_app/data/dto/recipe_dto.dart';
import 'package:equifax_app/domain/entity/recipe.dart';

abstract class SpoonacularApi {
  Future<List<Recipe>> getRandomRecipes();
}

class SpoonacularApiImpl implements SpoonacularApi {
  final _dio = Dio();

  @override
  Future<List<Recipe>> getRandomRecipes() async {
    try {
      Response response;
      response = await _dio.get(
          "https://api.spoonacular.com/recipes/random?apiKey=bcaa49c492c948dc99175ac11e8dcb66&number=20");

      return (response.data["recipes"] as List)
          .map((e) => RecipeDto.fromJson(e))
          .toList();
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('');
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);

        //  API responds with 404 when reached the end
        if (e.response?.statusCode == 404) return [];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      return [];
    }
  }
}
