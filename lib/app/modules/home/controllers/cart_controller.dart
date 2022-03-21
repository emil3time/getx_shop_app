import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/cart_item_model.dart';

class CartController extends GetxController {
  final RxMap<String, CartItem> _cartMap = <String, CartItem>{}.obs;
  // getter cartmap
  Map<String, CartItem> get cartMap {
    return {..._cartMap};
  }

  RxInt _cartCounter = 0.obs;
  // AppBar  cart counter
  String get cartCounter {
    return _cartCounter.value.toString();
  }

  RxDouble _totalAmount = 0.0.obs;

  final _toatlAmt = 0.0.obs;

  double get totalAmt {
    double total = 0.0;
    _cartMap.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity.value;
    });
    _toatlAmt.value = total;
    return _toatlAmt.value;
  }

  set totalAmt(value) => _toatlAmt.value = value;

  /* double get totalAmount {
    var total = 0.0;
    _cartMap.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity.value;
    });
    _totalAmount.value = total;
    return total;
  } */

  // remowe by compare key to productId (productId is both key and product id)
  void removeCartItem({required String productId, required int quantity}) {
    _cartMap.remove(productId);
    _cartCounter - quantity;
  }

  // alternative way - remove by compare ulr
  void removeCartItem2({required String imageUrl, required int quantity}) {
    _cartMap.removeWhere((key, value) => value.imageUrl == imageUrl);

    _cartCounter - quantity;
  }

  void removeAllCartItems() {
    _cartMap.value = {};
    _cartCounter.value = 0;
    // print(_orders);
  }

  void showAddOrderSnackBar() {
    if (totalAmt != 0) {
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

  /////
  void addCartItem(
      String productId, double price, String title, String imageUrl) {
    if (_cartMap.containsKey(productId)) {
      _cartMap.update(productId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          itemName: existingCartItem.itemName,
          imageUrl: imageUrl,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        );
      });
    } else {
      _cartMap.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          itemName: title,
          imageUrl: imageUrl,
          price: price,
          quantity: 1.obs,
        ),
      );
    }

    print(_cartMap.length);
    print(cartCounter);
    _cartCounter++;
  }
}
