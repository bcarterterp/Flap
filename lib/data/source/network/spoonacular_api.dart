import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';

abstract class SpoonacularApi {
  final Dio dio;
  SpoonacularApi({required this.dio});

  Future<RequestResponse<List<Recipe>, DioException>> getRandomRecipes();
}
