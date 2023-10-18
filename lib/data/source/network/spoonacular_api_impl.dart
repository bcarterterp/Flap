import 'package:dio/dio.dart';
import 'package:flap_app/data/dto/recipe_dto.dart';
import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/env/env.dart';

class SpoonacularApiImpl implements SpoonacularApi {
  final Dio dio;
  
  final Uri spoonacularUri = Uri(
    scheme: "https",
    host: "api.spoonacular.com",
    path: "recipes/random",
    queryParameters: {
      "number": "20",
      "apiKey": Env.spoonacularApiKey,
    },
  );


  SpoonacularApiImpl({required this.dio});

  @override
  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes() async {
    try {
      Response response;
      response = await dio.get(spoonacularUri.toString());

      final recipeListResponse = (response.data["recipes"] as List)
          .map((response) => RecipeDto.fromJson(response))
          .toList();
      return Future.value(SuccessRequestResponse(recipeListResponse));
    } on DioException catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        //Uses DioException types to print error message
        print(error);
        return Future.value(ErrorRequestResponse(error));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Future.value(ErrorRequestResponse(error));
      }
    }
  }
}
