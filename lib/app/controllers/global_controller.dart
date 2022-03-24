import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';

class GlobalController extends GetxController {
  final managerController = Get.put(ManagerController());

  final box = GetStorage();

  @override
  void onInit()  {
    managerController.httpFetchProduct();
    super.onInit();
  }
}
