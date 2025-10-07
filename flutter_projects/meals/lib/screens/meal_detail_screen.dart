import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/widgets/dietary_info_chip.dart';
import 'package:meals/widgets/ingredients_list.dart';
import 'package:meals/widgets/meal_detail_header.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:meals/widgets/section_title.dart';
import 'package:meals/widgets/steps_list.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? '${meal.title} added to favorites'
                        : '${meal.title} removed from favorites',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MealDetailHeader(imageUrl: meal.imageUrl),
            const SizedBox(height: 14),
            _buildInfoCards(context),
            const SizedBox(height: 14),
            DietaryInfoChips(meal: meal),
            const SizedBox(height: 14),
            const SectionTitle(title: 'Ingredients'),
            IngredientsList(ingredients: meal.ingredients),
            const SizedBox(height: 14),
            const SectionTitle(title: 'Steps'),
            StepsList(steps: meal.steps),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MealItemTrait(
            icon: Icons.schedule,
            value: '${meal.duration} min',
            label: 'Duration',
          ),
          MealItemTrait(
            icon: Icons.work,
            value: complexityText,
            label: 'Complexity',
          ),
          MealItemTrait(
            icon: Icons.attach_money,
            value: affordabilityText,
            label: 'Cost',
          ),
        ],
      ),
    );
  }
}
