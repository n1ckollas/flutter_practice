import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/11/providers/filters_provider.dart';
import 'package:meals/11/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvier);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == "meals") {
            Navigator.of(context).pop();
          }
        },
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvier.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: const Text("Gluten Free"),
            subtitle: const Text("Include only Gluten Free Meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvier.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: const Text("Lactose Free"),
            subtitle: const Text("Include only Lactose Free Meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvier.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: const Text("Vegetarian"),
            subtitle: const Text("Include only Vegetarian Meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvier.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: const Text("Vegan"),
            subtitle: const Text("Include only Vegan Meals."),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ],
      ),
    );
  }
}
