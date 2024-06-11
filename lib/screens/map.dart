import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meals/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
        latitude: 37.422, longtitude: -122.084, address: ""),
    this.isSelecting = true,
  });
  final PlaceLocation location;
  final bool isSelecting;
  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  late LatLng pickedLocation;
  @override
  void initState() {
    super.initState();
    pickedLocation = LatLng(
      widget.location.latitude!,
      widget.location.longtitude!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? "Pick your location" : "Your Location"),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {}, icon: Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          print(position);
          setState(() {
            pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude!,
            widget.location.longtitude!,
          ),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("M1"),
            position: pickedLocation,
          ),
        },
      ),
    );
  }
}
