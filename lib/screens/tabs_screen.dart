import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorite_screen.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<Map<String,Object>> pages;
  int selectedPageIndex=0;

  @override
  void initState() {
    pages=[
      {'page':CategoriesScreen(),
        'title':'Categories'},
      {
        'page':FavoriteScreen(widget.favoriteMeals),
        'title':'Favorites'
      }
    ];    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pages[selectedPageIndex]['title'].toString()),),
      body: pages[selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor:Colors.white,
        currentIndex: selectedPageIndex,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category),label:"Categories" ),
          BottomNavigationBarItem(icon: Icon(Icons.star),label:"Favorites" ),

        ],
      ),
      drawer: MainDrawer(),
    );
  }

 void _selectPage(int value) {
    setState((){
      selectedPageIndex=value;
    });
  }
}
