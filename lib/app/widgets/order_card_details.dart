import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';

import '../model/order_model.dart';

class OrderCardDetails extends GetView<OrderController> {
  final OrderItem orderItem;
  OrderCardDetails({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    var cartProducts = controller.createCartProducts(orderItem);

    return ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, i) => cartProducts[i]);
  }
}
