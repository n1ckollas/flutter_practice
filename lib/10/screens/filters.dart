import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/10/providers/filters_provider.dart';
import 'package:meals/10/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Filters"),
        ),
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
                    .watch(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
              title: const Text("Gluten Free"),
              subtitle: const Text("Includ Only Gluten Free meals."),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .watch(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
              },
              title: const Text("Lactose Free"),
              subtitle: const Text("Includ Only Lactose Free meals."),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isChecked) {
                ref
                    .watch(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
              },
              title: const Text("Vegatarian"),
              subtitle: const Text("Includ Only Vegetarian meals."),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (isChecked) {
                ref
                    .watch(filtersProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
              },
              title: const Text("Vagan"),
              subtitle: const Text("Includ Only Vegan meals."),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ));
  }
}
