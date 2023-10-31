import 'package:dio/dio.dart';
import 'package:flap_app/data/dto/recipe_dto.dart';
import 'package:flap_app/data/source/network/spoonacular_api.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flap_app/util/env/env.dart';

class SpoonacularApiImpl implements SpoonacularApi {
  final Dio dio;
  final FlavorRepository flavorRepo;
  late final String baseUrlHost;
  late final Uri spoonacularUri;

  SpoonacularApiImpl({required this.dio, required this.flavorRepo}){
    baseUrlHost = flavorRepo.getBaseUrlHost();
    spoonacularUri = Uri(
      scheme: "https",
      host: baseUrlHost,
      path: "recipes/random",
      queryParameters: {
        "number": "20",
        "apiKey": Env.spoonacularApiKey,
      },
    );
  }

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
