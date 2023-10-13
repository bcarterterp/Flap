import 'package:dio/dio.dart';
import 'package:flap_app/data/dto/recipe_dto.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';

abstract class SpoonacularApi {
  final Dio dio;
  SpoonacularApi({required this.dio});

  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes();
}

class SpoonacularApiImpl implements SpoonacularApi {
  final Dio dio;

  SpoonacularApiImpl({required this.dio});

  @override
  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes() async {
    try {
      Response response;
      //TODO: When Envied is implemented to hide api key, a solution for building the full URL will be implemented
      response = await dio
          .get("https://api.spoonacular.com/recipes/random?&number=20");

      final recipeListResponse = (response.data["recipes"] as List)
          .map((response) => RecipeDto.fromJson(response))
          .toList();
      return Future.value(Success(recipeListResponse));
    } on DioException catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        //Uses DioException types to print error message
        print(error);
        return Future.value(Error(error));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Future.value(Error(error));
      }
    }
  }
}
