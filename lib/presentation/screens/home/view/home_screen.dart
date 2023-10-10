import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/widgets/recipe_grid_item.dart';
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
    final recipeList = state.recipeList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page Screen'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          if (state.isSuccess() && recipeList != null)
            for (final recipe in recipeList) RecipeGridItem(recipe: recipe)
        ],
      ),
    );
  }
}
