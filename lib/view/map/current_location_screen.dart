import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );
  Set<Marker> markers = {};
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User current location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: selectedLocation != null
            ? CameraPosition(target: selectedLocation!, zoom: 14)
            : initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        onTap: (LatLng location) async {
          if (selectedLocation != null) {
            // Convert selected location to a place name
            List<Placemark> placemarks = await placemarkFromCoordinates(
              selectedLocation!.latitude,
              selectedLocation!.longitude,
            );

            setState(() {
              selectedLocation = location;
              markers.clear();
              markers.add(
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: location,
                  draggable: true,
                  onDragEnd: (LatLng newLocation) {
                    setState(() {
                      selectedLocation = newLocation;
                    });
                  },
                ),
              );
            });

            if (placemarks.isNotEmpty) {
              String placeName = placemarks[0].name ?? "Unknown Place";
              print("Selected Location: $placeName");
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          // Convert current location to a place name
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isNotEmpty) {
            String placeName = placemarks[0].name ?? "Unknown Place";
            print("Current Location: $placeName");

            // Update the marker title with the place name
            markers.clear();
            markers.add(
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: LatLng(position.latitude, position.longitude),
                infoWindow: InfoWindow(title: placeName),
              ),
            );

            // Animate camera to the new location
            googleMapController.animateCamera(CameraUpdate.newLatLng(
                LatLng(position.latitude, position.longitude)));

            setState(() {});
          }
        },
        label: const Text("Current location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
