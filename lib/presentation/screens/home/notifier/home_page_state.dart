import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/recipe.dart';

class HomePageState {
  HomePageState({required this.loadRecipesEvent, this.recipeList});

  final Event<List<Recipe>, DioException>? loadRecipesEvent;

  final List<Recipe>? recipeList;

  factory HomePageState.initial() => HomePageState(
        loadRecipesEvent: InitialEvent(),
      );

  factory HomePageState.loading() => HomePageState(
        loadRecipesEvent: LoadingEvent(),
      );

  factory HomePageState.success(List<Recipe> recipeList) => HomePageState(
        loadRecipesEvent: EventSuccess(recipeList),
        recipeList: recipeList,
      );

  factory HomePageState.error(DioException error) =>
      HomePageState(loadRecipesEvent: EventError(error));

  bool isLoading() {
    return loadRecipesEvent is LoadingEvent;
  }

  bool isSuccess() {
    return loadRecipesEvent is EventSuccess;
  }
}
