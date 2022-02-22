import "package:flutter/material.dart";

import '../dummy_data.dart';
import "../models/meal.dart";
import "../widgets/meal_item.dart";

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals"; // a property which can be accessed without instantiating the class
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  // @override
  // void initState() { // won't work if context is needed (throws an error)
  //   super.initState();
  // }

  @override
  void didChangeDependencies() { // will work if context is needed
    super.didChangeDependencies();

    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs["id"];
      categoryTitle = routeArgs["title"];
      displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }
  
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: displayedMeals[index].id,
          name: displayedMeals[index].name,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          complexity: displayedMeals[index].complexity,
          affordability: displayedMeals[index].affordability,
          removeItem: _removeMeal,
        );
      },
      itemCount: displayedMeals.length,
      ),
    );
  }
}