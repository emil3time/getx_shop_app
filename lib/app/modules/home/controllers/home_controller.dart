import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/cart_item_model.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/model/product_model.dart';

class HomeController extends GetxController {
  RxList<Product> dummyList = <Product>[
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ].obs;

  // RxBool where use switches
  RxBool showOnlyFavorite = false.obs;
  // switch for favorite
  void switchTooFavorites() {
    showOnlyFavorite.value = true;
    print(showOnlyFavorite);
  }

  // switch for all
  void switchTooAll() {
    showOnlyFavorite.value = false;
    print(showOnlyFavorite);
  }

  // List of Products marked as favorite
  List<Product> get onlyFavoriteList {
    return dummyList.where((e) => e.isFavorite.value).toList();
  }

  // create get to chandle private class
/*   List<Product> get dummyList {
    return [..._dummyList];
  } */

// choose between the favorites list and the all list
  List<Product> get favoriteOrAll {
    if (showOnlyFavorite.value) {
      return [...onlyFavoriteList];
    } else {
      return [...dummyList];
    }
  }

// firstWhere list method return first element where condition == true
//
  Product findSingleProductById(String id) {
    return dummyList.firstWhere((e) => e.id == id);
  }

// Cart loigic
  RxMap<String, CartItem> _cartMap = <String, CartItem>{}.obs;
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

  var _toatlAmt = 0.0.obs;

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
    print(_orders);
  }

  void showAddOrderSnackBar() {
    if (totalAmt != 0)
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

  /////////////////////////////////////////////////////////////////
  /// Order logic
  ///
  ///
  ///

  RxList<OrderItem> _orders = <OrderItem>[].obs;

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
              amount: totalAmt,
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

  ///////
  ///
  ///
  ///
  //
  addNewProduct() {


  }
}
