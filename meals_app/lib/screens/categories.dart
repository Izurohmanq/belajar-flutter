import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavourite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;


  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
      .where((meal) => meal.categories
      .contains(category.id))
      .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => 
        MealsScreen(
          title: category.title, 
          meals: filteredMeals,
          onToggleFavourite: onToggleFavourite,
        ),
      ),
    );  //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, // space between the column
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItems(category: category,)).toList() --> alternative digunakan selain menggunakan for loop
          for (final category in availableCategories) 
            CategoryGridItems(
              category: category,
              onSelectedCategory: () {
                _selectedCategory(context, category);
              },
            )
        ],
    );
  }
}