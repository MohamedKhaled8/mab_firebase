import 'package:working/core/routes/route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:working/features/home_view/ui/home_sceen.dart';
import 'package:working/features/login_screen/ui/login_screen_work.dart';


class AppBagets {
  static const initial = Routes.login;
  static final routes = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      // binding: LoginBinding(),
    ),
  ];
}
