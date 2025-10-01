import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.onToggleFavorite,
    required this.favoriteMeals,
  });

  final String title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favoriteMeals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void _selectMeal(BuildContext context, Meal meal) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
          onToggleFavorite: widget.onToggleFavorite,
          isFavorite: widget.favoriteMeals.contains(meal),
        ),
      ),
    );
    // Rebuild this screen when we come back from detail screen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );

    if (widget.meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: widget.meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: widget.meals[index],
          onSelectMeal: () {
            _selectMeal(context, widget.meals[index]);
          },
          isFavorite: widget.favoriteMeals.contains(widget.meals[index]),
          onToggleFavorite: widget.onToggleFavorite,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: content,
    );
  }
}
