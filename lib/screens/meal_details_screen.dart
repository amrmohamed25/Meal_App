import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routeName = "/meal_details";
  Function toggleFavorites;
  Function isFavorite;
  MealDetailsScreen(this.toggleFavorites,this.isFavorite);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget buildSectionTitle({required context, required text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer({required child}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.grey)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    Meal selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context: context, text: "Ingredients"),
            buildContainer(
              child: ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ));
                  }),
            ),
            buildSectionTitle(context: context, text: "Steps"),
            buildContainer(
              child: ListView.builder(
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.pink,
                              child: Text(
                                "# ${index + 1}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(selectedMeal.steps[index])),
                        Divider()
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          setState((){          widget.toggleFavorites(selectedMeal.id);
          });
        },
        child: Icon(widget.isFavorite(selectedMeal.id)?Icons.star:Icons.star_border),
      ),
    );
  }
}
