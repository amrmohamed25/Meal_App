import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile({required myIcon,required title,required function}){
    return  ListTile(
      leading:  Icon(myIcon,size: 26,),
      title:  Text(title,style:const TextStyle(
          fontSize: 24,fontFamily: "RobotoCondensed"
          ,fontWeight: FontWeight.bold
      ),
      ),
      onTap: function,
    );

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height:120 ,
            width:double.infinity,
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.all(20),
            child:  Text("Cooking Up!",
            style: TextStyle(fontSize:30,fontWeight:FontWeight.w900,
            color: Theme.of(context).primaryColor),),
          ),
          const SizedBox(height: 20,),
          buildListTile(myIcon: Icons.restaurant, title: "Meal",function: (){Navigator.of(context).pushReplacementNamed("/");}),
          buildListTile(myIcon: Icons.settings, title: "Filters",function: (){Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);})
        ],
      ),
    );
  }
}
