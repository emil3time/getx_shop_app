import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';

import '../controllers/home_controller.dart';
import '../controllers/manager_controller.dart';

class MenagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
