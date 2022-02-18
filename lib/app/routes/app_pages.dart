import 'package:get/get.dart';

import 'package:getx_shop_app/app/modules/home/bindings/home_binding.dart';
import 'package:getx_shop_app/app/modules/home/views/home_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreenView(),
      binding: HomeBinding(),
    ),
  ];
}
