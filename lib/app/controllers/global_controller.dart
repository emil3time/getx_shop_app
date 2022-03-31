import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';

class GlobalController extends GetxController {
  final managerController = Get.put(ManagerController());
  final orderController = Get.put(OrderController());

  final box = GetStorage();

  @override
  void onInit() {
    managerController.httpFetchProduct();
    orderController.httpFethOrders();
    super.onInit();
  }
}
