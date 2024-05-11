import 'package:flutter/material.dart';
import 'package:meals/00-OG/screens/tabs.dart';
import 'package:meals/10/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget{
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });
  final Map<Filter,bool> currentFilters;

  @override
  State<FiltersScreen> createState(){
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen>{
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier){
          Navigator.of(context).pop();
          if(identifier == "meals"){
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet,
            });
          }
        },
      ),
      body:Column(
        children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged:(isChecked) {
              setState(() {
                _glutenFreeFilterSet = isChecked;
              });
            },
            title: Text("Gluten Free"),
            subtitle: Text("Includ Only Gluten Free meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _lactoseFreeFilterSet,
            onChanged:(isChecked) {
              setState(() {
                _lactoseFreeFilterSet = isChecked;
              });
            },
            title: const Text("Lactose Free"),
            subtitle: const Text("Includ Only Lactose Free meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _vegetarianFilterSet,
            onChanged:(isChecked) {
              setState(() {
                _vegetarianFilterSet = isChecked;
              });
            },
            title: const Text("Vegatarian"),
            subtitle: const Text("Includ Only Vegetarian meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: _veganFilterSet,
            onChanged:(isChecked) {
              setState(() {
                _veganFilterSet= isChecked;
              });
            },
            title: const Text("Vagan"),
            subtitle: const Text("Includ Only Vegan meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ],
      )
    );
  }
}