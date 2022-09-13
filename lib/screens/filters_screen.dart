import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  Function saveFilters;
  final Map<String,bool> currentFilters;
  FiltersScreen(this.currentFilters,this.saveFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
  bool isLactoseFree = false;
  bool isVegan = false;
  bool isVegetarian = false;



  @override
  initState(){
     isGlutenFree = widget.currentFilters["gluten"]??false;
     isLactoseFree = widget.currentFilters["lactose"]??false;
     isVegan = widget.currentFilters["vegan"]??false;
     isVegetarian = widget.currentFilters["vegetarian"]??false;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String description,
      bool currentValue, void Function(bool)? updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(description),
      activeColor: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(icon:Icon(Icons.save),
          onPressed:() {
            final Map<String,bool> selectedFilters={
              'gluten':isGlutenFree,
              'lactose':isLactoseFree,
              'vegetarian':isVegetarian,
              'vegan':isVegan,
            };
            widget.saveFilters(selectedFilters);
          },)
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile("Gluten-Free",
                    "Only include gluten-free meals", isGlutenFree, (p0) {
                  setState(() {
                    isGlutenFree = p0;
                  });
                }),

                buildSwitchListTile("Lactose-Free",
                    "Only include lactose-free meals", isLactoseFree, (p0) {
                      setState(() {
                        isLactoseFree = p0;
                      });
                    }),

                buildSwitchListTile("Vegetarian",
                    "Only include vegetarian meals", isVegetarian, (p0) {
                      setState(() {
                        isVegetarian = p0;
                      });
                    }),

                buildSwitchListTile("Vegan",
                    "Only include Vegan meals", isVegan, (p0) {
                      setState(() {
                        isVegan = p0;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
