import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_state_notifier.g.dart';

@riverpod
class HomeScreenStateNotifier extends _$HomeScreenStateNotifier {
  @override
  HomeScreenState build() => HomeScreenState.initial();

  Future<void> getRandomRecipes() async {
    if (state.loadRecipesEvent is LoadingEvent) {
      return;
    }
    state = HomeScreenState.loading();

    final response =
        await ref.read(recipeRepositoryProvider).getRandomRecipes();

    switch (response) {
      case SuccessRequestResponse<List<Recipe>, DioException>():
        state = HomeScreenState.success(response.data);
      case ErrorRequestResponse<List<Recipe>, DioException>():
        state = HomeScreenState.error(response.error);
    }
  }
}
