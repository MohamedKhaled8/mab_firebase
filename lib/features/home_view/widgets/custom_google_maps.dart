import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:working/controller/map_controller/map_controller.dart';

class CustomGoogleMapsScreen extends StatelessWidget {
  CustomGoogleMapsScreen({Key? key}) : super(key: key);
  final MapController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (LatLng position) {
              _controller.onMapTapped(position);
            },
            markers: Set<Marker>.of(_controller.markers),
            polylines: Set<Polyline>.of(_controller.polylines),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: _controller.myCurrentLocationCameraPosition!,
            onMapCreated: (GoogleMapController controller) {
              _controller.mapCompleter.complete(controller);
            },
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                _controller.clearMarkers(); // Method to clear the markers
              },
              child: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
