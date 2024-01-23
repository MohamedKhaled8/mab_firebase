import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:working/controller/map_controller/map_controller.dart';
import 'package:working/features/home_view/widgets/custom_google_maps.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final MapController _controllerImp = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(builder: (_) {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _controllerImp.position != null
                  ? CustomGoogleMapsScreen()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _controllerImp.gotoMyCurrentLocation();
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.place, color: Colors.white),
            ),
          ],
        ),
      );
    });
  }
}
