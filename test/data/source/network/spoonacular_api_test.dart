import 'package:dio/dio.dart';
import 'package:flap_app/data/source/network/spoonacular_api_impl.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late SpoonacularApiImpl spoonacularApi;

  group('getRandomRecipes', () {
    setUp(() {
      dio = Dio(BaseOptions());
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      spoonacularApi = SpoonacularApiImpl(dio: dio);
    });

    test(
        'returns recipe list and a success request response object upon 200 code',
        () async {
      dioAdapter.onGet(
        "",
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
      expect(response, isA<SuccessRequestResponse<List<Recipe>, DioException>>());
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
