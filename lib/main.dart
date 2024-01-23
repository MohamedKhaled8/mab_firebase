import 'package:get/get.dart';
import 'core/helper/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:working/sub_main.dart';
import 'core/networking/login_networking.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/login_screen/data/repo/login_repo_imp.dart';
import 'package:working/core/networking/home_networking.dart';
import 'package:working/controller/map_controller/map_controller.dart';
import 'package:working/features/home_view/data/repo/get_markers_repo_imp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MapController().getMyCurrentLocation();
  Get.put(LoginRepoImp(LoginNetworking(DioHelper())));
  runApp(const MyApp());
}
