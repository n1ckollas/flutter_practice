import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ])),
              child: Row(children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                ),
                Text("Cooking Up!")
              ])),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text("Meals"),
            onTap: () {
              onSelectScreen("meals");
            },
          )
        ],
      ),
    );
  }
}
