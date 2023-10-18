import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_state_notifier_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late HomePageStateNotifier notifier;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    notifier = HomePageStateNotifier(recipeRepository: mockRecipeRepository);
  });

  group('getRandomRecipes', () {
    test('returns success and updates HomePageState with recipeList', () async {
      const recipes = [Recipe(id: 1), Recipe(id: 2)];
      SuccessRequestResponse<List<Recipe>, DioException> successResponse =
          SuccessRequestResponse<List<Recipe>, DioException>(recipes);
      //Without the below provideDummy, an error will be thrown because the generated mock class requires a dummy value(line 45 in the mocks.dart equivalent of this class)
      provideDummy<RequestResponse<List<Recipe>, DioException>>(
          successResponse);

      //Below is stubbed behavior for the getRandomRecipes call to return a successResponse
      when(mockRecipeRepository.getRandomRecipes()).thenAnswer((_) async =>
          Future<SuccessRequestResponse<List<Recipe>, DioException>>.value(
              successResponse));

      // Call the getRandomRecipes method
      await notifier.getRandomRecipes();

      // Verify that HomePageState is updated with a recipe list
      expect(
          (notifier.state as SuccessEvent).data,
          (HomePageState.success(recipes).loadRecipesEvent as SuccessEvent)
              .data);
    });

    test(
        'returns error and updates HomePageState with error state and error message',
        () async {
      final errorType = DioException.connectionError(
          requestOptions: RequestOptions(), reason: "Mock Error");
      final errorResponse =
          ErrorRequestResponse<List<Recipe>, DioException>(errorType);
      //Without the below provideDummy, an error will be thrown because the generated mock class requires a dummy value(line 45)
      provideDummy<RequestResponse<List<Recipe>, DioException>>(errorResponse);

      //Below is stubbed behavior for the getRandomRecipes call to return an errorResponse
      when(mockRecipeRepository.getRandomRecipes())
          .thenAnswer((_) async => Future.value(errorResponse));

      // Call the getRandomRecipes method
      await notifier.getRandomRecipes();

      // Verify that HomePageState has a loadRecipesEvent that is an ErrorEvent
      expect(notifier.state is EventError, true);
    });
  });
}
