import 'package:flutter/material.dart';

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
  @override
  Widget build(context){
    return Text("I am Filters");
  }
}