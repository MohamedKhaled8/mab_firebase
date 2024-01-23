import 'package:flutter/material.dart';
import 'package:working/core/routes/app_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialRoute: AppBagets.initial,
          getPages: AppBagets.routes,
          // initialBinding: InitialBindings(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
