import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/cart_item_model.dart';
import '../../../model/order_model.dart';

class OrderController extends GetxController {
  final RxList<OrderItem> _orders = <OrderItem>[].obs;

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartItems, double totalAmount) {
    if (totalAmount == 0) {
      null;
    } else {
      _orders.insert(
          0,
          OrderItem(
              amount: totalAmount,
              dateTime: DateTime.now(),
              id: DateTime.now().toString(),
              orderProducts: cartItems));
    }
  }

  List<Widget> createCartProducts(OrderItem orderItem) {
    return orderItem.orderProducts
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    e.itemName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Spacer(),
                  Text(
                    '${e.quantity.value.toString()} x ${e.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ))
        .toList();
  }

  /* bool showDetalis = true; */

  void togleShowDetails(OrderItem orderItem) {
    orderItem.detailsShown = !orderItem.detailsShown;
    update();
    /* print(detailedShown); */
  }
}
