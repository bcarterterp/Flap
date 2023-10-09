import 'package:flap_app/domain/entity/recipe.dart';

class HomePageState {
  const HomePageState({this.randomRecipes});

  final List<Recipe>? randomRecipes;

  HomePageState copyWith({List<Recipe>? randomRecipes}) {
    return HomePageState(randomRecipes: randomRecipes);
  }
}
