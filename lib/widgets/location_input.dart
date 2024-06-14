import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import "package:http/http.dart" as http;
import 'package:meals/models/place.dart';
import 'package:meals/screens/map.dart';

const gApiKey = "AIzaSyD7_jlz3A_vn-17VcO22aC9uwJYT5hv36M";
const signature = "57DI8aoHcHlgHUo-PuQAygb6Emc=";

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  var isGettingLocation = false;

  String get locationImage {
    return "https://maps.googleapis.com/maps/api/staticmap?center=${pickedLocation!.latitude},${pickedLocation!.longtitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${pickedLocation!.latitude},${pickedLocation!.longtitude}&key=$gApiKey";
  }

  void savePlace(double lat, double lng) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$gApiKey");
    final response = await http.get(url);
    var resData = json.decode(response.body);
    final address = resData["results"][0]["formatted_address"];
    setState(() {
      pickedLocation =
          PlaceLocation(latitude: lat, longtitude: lng, address: address);
      isGettingLocation = false;
    });
    widget.onSelectLocation(pickedLocation!);
  }

  void getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGettingLocation = true;
    });

    _locationData = await location.getLocation();
    var lat = _locationData.latitude;
    var lng = _locationData.longitude;
    if (lat == null || lng == null) {
      return;
    }
    savePlace(lat, lng);
  }

  void _selectOnMap() async {
    final result = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    savePlace(result!.latitude, result.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      "No location chosen.",
      style: TextStyle(
        color: Colors.white,
      ),
    );
    if (pickedLocation != null) {
      print("I work");
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: getCurrentLocation,
              label: const Text(
                "Get Current Location",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: _selectOnMap,
              label: const Text("Select On Map"),
            ),
          ],
        ),
      ],
    );
  }
}
