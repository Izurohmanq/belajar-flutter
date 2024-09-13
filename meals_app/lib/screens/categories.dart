import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController; //bawaan dari Flutter

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
      .where((meal) => meal.categories
      .contains(category.id))
      .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => 
        MealsScreen(
          title: category.title, 
          meals: filteredMeals,
        ),
      ),
    );  //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController, 
      child: GridView(
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
      ),
    builder: (context, child) => SlideTransition(
      position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: _animationController, 
          curve: Curves.easeInOut,
        )),
      child: child,
    ),
  );    
  }
}