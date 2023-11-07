import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/l10n/app_localizations_context.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/notifier/home_screen_state.dart';
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
      ref.read(homePageStateProvider.notifier).getRandomRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageStateProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(context.localization.home),
        ),
        body: switch (state.loadRecipesEvent) {
          InitialEvent() => const LoadingScreenWidget(),
          LoadingEvent() => const LoadingScreenWidget(),
          SuccessEvent() => RecipeGrid(state: state),
          EventError() => const ErrorScreenWidget(),
        });
  }
}

class RecipeGrid extends ConsumerWidget {
  final HomePageState state;

  const RecipeGrid({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeList = ref.watch(recipeListProvider);
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        if (state.loadRecipesEvent is SuccessEvent)
          for (final recipe in recipeList) RecipeGridItem(recipe: recipe)
      ],
    );
  }
}
