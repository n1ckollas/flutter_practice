import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/user_laces.dart';
import 'package:meals/screens/add_place.dart';
import 'package:meals/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext contexts) {
    final places = ref.watch(userPlacesProvider);
    print(places);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddPlaceScreen()));
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(places: places),
        ));
  }
}
