import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals';
  List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  void removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((element) => element.id==mealId);
    });
    print("hahahhaha");
    print(categoryMeals);
  }

  late String categoryTitle;
  late String categoryId;
  late List<Meal> categoryMeals;

  @override
  void didChangeDependencies() {
    final routeArg =
    ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryId = routeArg["id"].toString();
    categoryTitle = routeArg["title"].toString();
    categoryMeals = widget.availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    print(categoryMeals);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Meal myMeal = categoryMeals[index];
          return MealItem(
              removeItem:removeMeal
              ,
              id: myMeal.id,
              imageUrl: myMeal.imageUrl,
              title: myMeal.title,
              duration: myMeal.duration,
              complexity: myMeal.complexity,
              affordability: myMeal.affordability);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
