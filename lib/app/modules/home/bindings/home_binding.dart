import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
     
  }
}
