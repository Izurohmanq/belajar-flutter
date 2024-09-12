import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegan:false,
    Filter.vegetarian:false,
  };

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScrenState();
  }
}

class _TabsScrenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage (String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message)
    ));
  }

  void _toggleMealFavourites (Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {  
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favourite');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage('Marked is Favourited');
      });
    }

  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setSccreen(String identifier) async {
      Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) =>  FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree ) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree ) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan ) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian ) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavourites,
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage =  MealsScreen(meals: _favouriteMeals, onToggleFavourite: _toggleMealFavourites,);
      activePageTitle = 'Favorit Kamyuh';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setSccreen,), // ini tuh tab dari samping
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label:'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label:'Favourites'),
        ],
      ),
    );
  }
}