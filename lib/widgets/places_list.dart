import 'package:flutter/material.dart';
import 'package:meals/models/place.dart';
import 'package:meals/screens/places_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (places.isEmpty) {
      return Center(
          child: Text("No pleaces added yet.",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  )));
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        // leading: CircleAvatar(
        //   radius: 26,
        //   backgroundImage: FileImage(places[index].image),
        // ),
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        subtitle: Text(places[index].location.address!),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => PlaceDetailScreen(place: places[index])),
          );
        },
      ),
    );
  }
}
