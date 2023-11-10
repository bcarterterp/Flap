import 'package:dio/dio.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/l10n/app_localizations_context.dart';
import 'package:flap_app/domain/entity/recipe.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state_notifier.dart';
import 'package:flap_app/presentation/screens/home/widgets/recipe_grid_item.dart';
import 'package:flap_app/presentation/screens/home/widgets/screen_states/error_screen.dart';
import 'package:flap_app/presentation/screens/home/widgets/screen_states/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeScreenStateNotifierProvider.notifier).getRandomRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeScreenStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.home),
      ),
      body: _getWidget(state.loadRecipesEvent),
    );
  }

  Widget _getWidget(Event<List<Recipe>, DioException> event) {
    switch (event) {
      case InitialEvent():
        return const LoadingScreenWidget();
      case LoadingEvent():
        return const LoadingScreenWidget();
      case SuccessEvent():
        return RecipeGrid(recipeList: event.data);
      case EventError():
        return const ErrorScreenWidget();
    }
  }
}

class RecipeGrid extends StatelessWidget {
  final List<Recipe> recipeList;

  const RecipeGrid({Key? key, required this.recipeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final recipe in recipeList) RecipeGridItem(recipe: recipe)
      ],
    );
  }
}
