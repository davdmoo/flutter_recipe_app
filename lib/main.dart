import 'package:flutter/material.dart';

import "./screens/tabs_screen.dart";
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import "./screens/meal_detail_screen.dart";
import "./screens/filters_screen.dart";
import "./dummy_data.dart";
import "./models/meal.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "glutenFree": false,
    "lactoseFree": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["glutenFree"] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactoseFree"] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] && !meal.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _favoriteHandler(String mealId) {
    final existingFavoriteIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingFavoriteIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingFavoriteIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlueAccent,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(fontSize: 20, fontFamily: "RobotoCondensed", fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      // home: CategoriesScreen(),
      routes: {
        "/": (ctx) => TabsScreen(_favoriteMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_favoriteHandler, _isMealFavorite),
      },
      onGenerateRoute: (settings) { // if there was an unknown route this will be called
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen()
        );
      },
      onUnknownRoute: (settings) { // if all else fails, this will be called
        return MaterialPageRoute(
          builder: (ctx) => Center(child: Text("404 NOT FOUND"))
        );
      },
    );
  }
}
