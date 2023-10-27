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

  group('getRandomRecipes', () {
    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      flavorRepo = MockFlavorRepository();
      when(flavorRepo.getBaseUrlHost()).thenAnswer((realInvocation) => "");
      spoonacularApi = SpoonacularApiImpl(dio: dio, flavorRepo: flavorRepo);
    });

    test(
        'returns recipe list and a success request response object upon 200 code',
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
      expect(
          response, isA<SuccessRequestResponse<List<Recipe>, DioException>>());
    });

    test('returns error request response object upon server error code 500',
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
