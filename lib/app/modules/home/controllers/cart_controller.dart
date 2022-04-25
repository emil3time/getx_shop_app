import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/infrastructure/fb_services/db/firebase.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';
import 'package:getx_shop_app/app/widgets/order_card.dart';

import '../../../model/cart_item_model.dart';

class CartController extends GetxController {
  var orderController = Get.put(OrderController());

  Order order = Order(
      amount: 0, dataTime: DateTime.now(), orderProducts: <CartProduct>[].obs);

  RxInt _cartCounter = 0.obs;
  String get cartCounter {
    return _cartCounter.value.toString();
  }

  final _toatlOrder = 0.0.obs;

  double get totalOrder {
    double total = 0.0;
    order.orderProducts.forEach((cartItem) {
      total += cartItem.price * cartItem.quantity.value;
    });
    _toatlOrder.value = total;
    return _toatlOrder.value;
  }

  set totalOrder(value) => _toatlOrder.value = value;

  final RxDouble _totalProduct = 0.0.obs;
  double get totalProduct {
    var total = 0.0;
    order.orderProducts.forEach((element) {
      element.quantity != 0;
      total += element.price * element.quantity.value;
    });

    /*  total += cartItem.price * cartItem.quantity.value; */
    _totalProduct.value = total;
    return total;
  }

  void addOrder(RxList<CartProduct> cartItems, double totalAmount) {
    if (totalAmount == 0) {
      null;
    } else {
      order = Order(
          amount: totalAmount,
          orderProducts: cartItems,
          dataTime: DateTime.now());
      orderController.orders.insert(0, order);
    }
  }

  Future<void> httpPostOrder() async {
    RealTimeDataBase().postOrder(order);
  }

  // remowe by compare key to productId (productId is both key and product id)
  void removeCartItem(CartProduct product) {
    order.orderProducts.removeWhere((element) => element.id == product.id);
    _cartCounter -= product.quantity.value;
    if (product.quantity.value == 0) {
      update();
    }
  }

  // alternative way - remove by compare ulr
  /* void removeCartItem2({required String imageUrl, required int quantity}) {
    order.removeWhere((key, value) => value.imageUrl == imageUrl);

    _cartCounter - quantity;
  } */

  void removeAllCartItems() {
    order.orderProducts.value = [];
    _cartCounter.value = 0;
    _totalProduct.value = 0;
  }

  void showAddOrderSnackBar() {
    if (totalOrder != 0) {
      Get.snackbar(
        'Order info',
        'a new order has been added',
        icon: Icon(
          Icons.send_and_archive,
        ),
        duration: Duration(
          seconds: 1,
        ),
      );
    }
  }

  //  cartController.order!.orderProducts.any((element) => element.id == product.id)

  void updateState() {
    update();
  }

  /////
  void addCartItem(CartProduct cartProduct) {
    if (order.orderProducts.any((element) => element.id == cartProduct.id)) {
      var index = order.orderProducts
          .indexWhere((element) => element.id == cartProduct.id);

      // order!.orderProducts[index].imageUrl= cartProduct.imageUrl;
      order.orderProducts[index].quantity += 1;
    } else {
      order.orderProducts.add(cartProduct);
    }
   

    _cartCounter++;
    update();
  }
}
