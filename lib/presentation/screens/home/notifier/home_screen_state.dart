import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';

class HomePageState {
  HomePageState({required this.loadRecipesEvent});

  final Event<List<Recipe>, DioException> loadRecipesEvent;

  factory HomePageState.initial() => HomePageState(
        loadRecipesEvent: InitialEvent(),
      );

  factory HomePageState.loading() => HomePageState(
        loadRecipesEvent: LoadingEvent(),
      );

  factory HomePageState.success(List<Recipe> recipeList) =>
      HomePageState(loadRecipesEvent: SuccessEvent(recipeList));

  factory HomePageState.error(DioException error) =>
      HomePageState(loadRecipesEvent: EventError(error));
}
