import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {

  List<Meal> favoriteMeals;
  FavoriteScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text("You have no favorites yet"),
      );
    }else {
      return ListView.builder(
        itemBuilder: (context, index) {
          Meal myMeal = favoriteMeals[index];
          return MealItem(
              removeItem:(){},
              id: myMeal.id,
              imageUrl: myMeal.imageUrl,
              title: myMeal.title,
              duration: myMeal.duration,
              complexity: myMeal.complexity,
              affordability: myMeal.affordability);
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
