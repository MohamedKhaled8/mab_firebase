import 'package:get/get.dart';
import 'package:working/controller/map_controller/map_controller.dart';
import 'package:working/controller/login_controller/login_controller.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => MapController(), fenix: true);
  }
}
// class InitialBindings extends Bindings {
//   @override
//   void dependencies() {
//     // Get.put(AuthHelper());
//     Get.put(DioClient());
//   }
// }
