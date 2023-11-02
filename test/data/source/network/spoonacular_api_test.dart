import 'package:dio/dio.dart';
import 'package:flap_app/data/source/network/spoonacular_api_impl.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/flavor/flavor_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'spoonacular_api_test.mocks.dart';

@GenerateMocks([FlavorRepository])
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late SpoonacularApiImpl spoonacularApi;
  late MockFlavorRepository flavorRepo;

  group('Spoonacular Api Unit Tests', () {
    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      flavorRepo = MockFlavorRepository();
      when(flavorRepo.getBaseUrlHost()).thenAnswer((realInvocation) => "");
      spoonacularApi = SpoonacularApiImpl(dio: dio, flavorRepo: flavorRepo);
    });

    test(
        'Given the spoonacular api instance, when the api returns a 200 success code, a recipe list wrapped in a success request response will be returned',
        () async {
      dioAdapter.onGet(
        spoonacularApi.spoonacularUri.toString(),
        (server) => server.reply(
          200,
          {
            'recipes': [
              {'id': 1}
            ]
          },
          delay: const Duration(seconds: 1),
        ),
      );
      final response = await spoonacularApi.getRandomRecipes();
      final recipeListResponse =
          ((response as SuccessRequestResponse<List<Recipe>, DioException>)
                  .data)
              .map((response) => response)
              .toList();
      expect(
          response, isA<SuccessRequestResponse<List<Recipe>, DioException>>());
      expect((response).data, recipeListResponse);
    });

    test(
        'Given the spoonacular api instance, when the api returns a 500 error code, an error response will be returned',
        () async {
      dioAdapter.onGet(
        "",
        (server) => server.reply(
          500,
          {
            'recipes': [
              {'id': 1}
            ]
          },
          delay: const Duration(seconds: 1),
        ),
      );
      final response = await spoonacularApi.getRandomRecipes();
      expect(response, isA<ErrorRequestResponse<List<Recipe>, DioException>>());
    });
  });
}
