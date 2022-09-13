import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((element) {
        if (filters["gluten"] == true && element.isGlutenFree == false) {
          return false;
        }
        if (filters["lactose"] == true && element.isLactoseFree == false) {
          return false;
        }
        if (filters["vegetarian"] == true && element.isVegetarian == false) {
          return false;
        }
        if (filters["vegan"] == true && element.isVegan == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex =
        favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      favoriteMeals
          .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
    }
  }

  bool isMealFavorite(String id){
    return favoriteMeals.any((element) => element.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge:
                    const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                bodyMedium:
                    const TextStyle(color: Color.fromRGBO(20, 50, 50, 1)),
                titleMedium: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(20, 50, 50, 1)),
              ),
          primaryColor: Colors.pink,
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(toggleFavorite,isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(filters, setFilters),
      },
    );
  }
}
