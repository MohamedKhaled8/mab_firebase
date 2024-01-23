import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:working/controller/map_controller/map_controller.dart';

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({
    super.key,
  });

  final MapController _controllerImp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 30).r,
      child: FloatingActionButton(
        onPressed: () {
          _controllerImp.gotoMyCurrentLocation();
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.place,
          color: Colors.white,
        ),
      ),
    );
  }
}
