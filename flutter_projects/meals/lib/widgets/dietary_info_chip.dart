import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';

class DietaryInfoChips extends StatelessWidget {
  const DietaryInfoChips({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final dietary = <Map<String, dynamic>>[];

    if (meal.isGlutenFree) {
      dietary.add({'icon': Icons.grain, 'label': 'Gluten-free'});
    }
    if (meal.isVegan) {
      dietary.add({'icon': Icons.eco, 'label': 'Vegan'});
    }
    if (meal.isVegetarian) {
      dietary.add({'icon': Icons.energy_savings_leaf, 'label': 'Vegetarian'});
    }
    if (meal.isLactoseFree) {
      dietary.add({'icon': Icons.no_food, 'label': 'Lactose-free'});
    }

    if (dietary.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: dietary.map((item) {
          return Chip(
            avatar: Icon(
              item['icon'] as IconData,
              size: 18,
              color: Colors.green,
            ),
            label: Text(item['label'] as String),
            backgroundColor: Colors.green.shade50,
          );
        }).toList(),
      ),
    );
  }
}
