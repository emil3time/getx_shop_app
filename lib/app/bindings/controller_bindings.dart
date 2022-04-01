

import 'package:get/get.dart';

import '../controllers/global_controller.dart';
import '../modules/home/controllers/autch_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController(), permanent: true);
    /* Get.put(AutchController(), tag: "auth"); */

  }

}
