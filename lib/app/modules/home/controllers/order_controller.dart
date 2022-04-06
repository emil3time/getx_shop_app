import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/infrastructure/fb_services/db/firebase.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/cart_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/cart_item_model.dart';
import '../../../model/order_model.dart';
import '../../../widgets/car_product_tile.dart';

class OrderController extends GetxController {
/*   final cartController = Get.find<CartController>(); */

/*   Order? order; */
  RxList<Order> orders = <Order>[].obs;

  Future<void> httpFethOrders() async {
    orders.value = await RealTimeDataBase()
        .featchOrders(authResponse['idToken'], authResponse['localId']);
    update();
  }

  var isLoading = false.obs;
  toogleIsLoading() {
    isLoading.value = !isLoading.value;
  }

  List<Widget> createCartProductsWidgets(Order orderItem) {
    return orderItem.orderProducts
        .map((e) => CartProductTile(product: e))
        .toList();
  }

  @override
  void onInit() async {
    await Future.delayed(Duration.zero).then((_) => httpFethOrders());
    super.onInit();
  }

  @override
  void onReady()  {

    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  /* bool showDetalis = true; */

/*   void togleShowDetails(OrderProduct orderItem) {
    orderItem.detailsShown = !orderItem.detailsShown;
    update();
    /* print(detailedShown); */
  } */

}
