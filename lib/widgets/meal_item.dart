import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  const MealItem(
      {required this.imageUrl,
      required this.title,
      required this.duration,
      required this.complexity,
      required this.affordability, required this.id, required this.removeItem});
  String get complexityText{
    if(complexity==Complexity.Challenging) {
      return "Challenging";
    } else if(complexity==Complexity.Simple) {
      return "Simple";
    } else if(complexity==Complexity.Hard) {
      return "Hard";
    }
    return "Unknown";
  }

  String get affordabilityText{
    if(affordability==Affordability.Affordable) {
      return "Affordable";
    } else if(affordability==Affordability.Luxurious) {
      return "Luxurious";
    } else if(affordability==Affordability.Pricey) {
      return "Pricey";
    }
    return "Unknown";
  }

  void selectMeal(BuildContext ctx) {
    print("lol");
    Navigator.pushNamed(ctx, "${MealDetailsScreen.routeName}",
    arguments: id
    ).then((value) {
      if(value!=null){
        removeItem(value);
      }
    });
  }
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap:()=> selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                        color: Colors.black54,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontSize: 26, color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        )))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 6,
                      ),
                      Text("$duration min")
                    ],
                  ),
                  Row(children: [
                    const Icon(Icons.work),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(complexityText)
                  ]),
                  Row(children: [
                    const Icon(Icons.attach_money),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(affordabilityText)
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
