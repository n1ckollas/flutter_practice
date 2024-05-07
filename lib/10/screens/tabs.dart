import 'package:flutter/material.dart';
import 'package:meals/10/data/dummy_data.dart';
import 'package:meals/10/models/meal.dart';
import 'package:meals/10/screens/filters.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState(){
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  
  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage("Remove Meal From Favorite");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Meal Added To Favorites");
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == "filters"){
      final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters
          )
        ) 
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(context){
    final availableMeals = dummyMeals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = Text("CategoriesScreen()");
    var activePageTitle = "Categories";

    if(_selectedPageIndex == 1){
      activePage = Text("mealsScreen()");
      activePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle)
      ),
      // drawer: MainDrawer(),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Catedgories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          )
        ],
      ),
    );
  }
}