import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/recipe/recipe_repository.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../util/listener.dart';
import '../../../../util/provider_container.dart';
import 'home_screen_state_notifier_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
  });

  group('HomeScreenNotifier Unit Test', () {
    test(
      'Given initial homeScreenNotifier, with getRandomRecipes called and error is returned, returns HomePageState with error',
      () async {
        const recipes = [Recipe(id: 1), Recipe(id: 2)];
        SuccessRequestResponse<List<Recipe>, DioException> successResponse =
            const SuccessRequestResponse<List<Recipe>, DioException>(recipes);
        //Without the below provideDummy, an error will be thrown because the generated mock class requires a dummy value(line 45 in the mocks.dart equivalent of this class)
        provideDummy<RequestResponse<List<Recipe>, DioException>>(
            successResponse);

        //Below is stubbed behavior for the getRandomRecipes call to return a successResponse
        when(mockRecipeRepository.getRandomRecipes()).thenAnswer((_) async =>
            Future<SuccessRequestResponse<List<Recipe>, DioException>>.value(
                successResponse));

        final container = createContainer(
          overrides: [
            recipeRepositoryProvider
                .overrideWith((ref) => mockRecipeRepository),
          ],
        );
        final stateListener = Listener<HomeScreenState>();
        container.listen(
          homeScreenStateNotifierProvider,
          (previous, next) {
            stateListener.call(previous, next);
          },
        );

        // Call the getRandomRecipes method
        await container
            .read(homeScreenStateNotifierProvider.notifier)
            .getRandomRecipes();

        // Verify that HomePageState is updated with a recipe list
        final states = stateListener.data;
        expect(states[0].$2, HomeScreenState.loading());
        expect(states[1].$2, HomeScreenState.success(recipes));
      },
    );

    test(
        'Given initial homeScreenNotifier, with getRandomRecipes called and success is returned, returns successful HomePageState',
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

      final container = createContainer(
        overrides: [
          recipeRepositoryProvider.overrideWith((ref) => mockRecipeRepository),
        ],
      );
      final stateListener = Listener<HomeScreenState>();
      container.listen(
        homeScreenStateNotifierProvider,
        (previous, next) {
          stateListener.call(previous, next);
        },
      );

      // Call the getRandomRecipes method
      await container
          .read(homeScreenStateNotifierProvider.notifier)
          .getRandomRecipes();

      // Verify that HomePageState has a loadRecipesEvent that is an ErrorEvent
      final states = stateListener.data;
      expect(states[0].$2, HomeScreenState.loading());
      expect(states[1].$2, HomeScreenState.error(errorType));
    });
  });
}
