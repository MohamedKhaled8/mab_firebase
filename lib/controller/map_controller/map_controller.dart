import 'dart:async';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/helper/dio_helper.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/error/login_failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:working/core/helper/location_helper.dart';
import 'package:working/core/networking/home_networking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../features/home_view/data/model/get_markers.dart';
import 'package:working/features/home_view/data/repo/get_markers_repo_imp.dart';

class MapController extends GetxController {
  Position? position;
  Completer<GoogleMapController> mapCompleter = Completer();
  CameraPosition? myCurrentLocationCameraPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> polylinePoints = [];
  StreamSubscription<Position>? positionStream;
  HomeRepoImp? homeRepoImp;
  MapController() {
    homeRepoImp = HomeRepoImp(HomeNetworking(DioHelper()));
    _initializeLocation();
    _loadAndDisplayMarkers();
  }

  Future<void> _loadAndDisplayMarkers() async {
    try {
      Map<String, dynamic> bodyData = {
        'Lat': position!.latitude,
        'Longt': position!.longitude,
        'Name': '',
      };
      Either<Failure, List<GetMarkerModel>> response =
          await homeRepoImp!.getMarkers(
        getMarkerModel: GetMarkerModel(
            lat: position!.latitude, longt: position!.longitude, name: ''),
        body: bodyData,
      );

      response.fold(
        (failure) => debugPrint('Error loading markers: ${failure.toString()}'),
        (markersData) {
          for (var markerData in markersData) {
            _addMarkerToMap(LatLng(position!.latitude, position!.longitude),
                markerData.name);
          }
        },
      );
      update();
    } catch (e, stacktrace) {
      debugPrint("Error loading markers: $e\n$stacktrace");
    }
  }

  void _addMarkerToMap(LatLng position, String title) {
    var markerId = MarkerId(title);
    var marker = Marker(
      markerId: markerId,
      position: position,
      infoWindow: InfoWindow(title: title),
    );
    markers.add(marker);
    update();
  }

  Future<void> _initializeLocation() async {
    position = await LocationHelper.getCurrentLocation();
    if (position != null) {
      myCurrentLocationCameraPosition = CameraPosition(
        target: LatLng(position!.latitude, position!.longitude),
        tilt: 0.0,
        zoom: 17,
        bearing: 0.0,
      );
      update();
    }
  }

  void addMarker(LatLng position) {
    var markerId = MarkerId(position.toString());
    var marker = Marker(markerId: markerId, position: position);
    markers.add(marker);
    update();
  }

  void onMapTapped(LatLng tappedPoint) {
    addMarker(tappedPoint);
    if (position != null) {
      LatLng myPosition = LatLng(position!.latitude, position!.longitude);
      polylinePoints.clear();
      polylinePoints.add(myPosition);
      polylinePoints.add(tappedPoint);
      addPolyline();
      sendLocationToFirebase(tappedPoint);
    }
  }

  void addPolyline() {
    var polyline = Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: polylinePoints,
      color: Colors.blue,
      width: 5,
    );
    polylines.add(polyline);
    update();
  }

  void startTracking() {
    positionStream = Geolocator.getPositionStream().listen(
      (Position newPosition) {
        LatLng newPoint = LatLng(newPosition.latitude, newPosition.longitude);
        addMarker(newPoint);
        polylinePoints.add(newPoint);
        addPolyline();
        sendLocationToFirebase(newPoint);
        updateCameraPosition(newPoint);
      },
    );
  }

  void stopTracking() {
    positionStream?.cancel();
  }

  void updateCameraPosition(LatLng newPoint) async {
    GoogleMapController controller = await mapCompleter.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newPoint,
          zoom: 17,
          tilt: 0.0,
          bearing: 0.0,
        ),
      ),
    );
  }

  void sendLocationToFirebase(LatLng position) async {
    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e, stacktrace) {
      debugPrint("Error sending location to Firebase: $e\n$stacktrace");
    }
  }

  Future<void> getMyCurrentLocation() async {
    Position? currentPosition = await Geolocator.getLastKnownPosition();
    if (currentPosition != null) {
      CameraPosition(
        target: LatLng(
          position!.latitude,
          position!.longitude,
        ),
        tilt: 0.0,
        zoom: 17,
        bearing: 0.0,
      );
      update();
    }
  }

  Future<void> gotoMyCurrentLocation() async {
    GoogleMapController controller = await mapCompleter.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition!),
    );
  }

  void clearMarkers() {
    markers.clear();
    polylinePoints.clear();
    update();
  }

  @override
  void onInit() {
    _initializeLocation();
    super.onInit();
  }
}
