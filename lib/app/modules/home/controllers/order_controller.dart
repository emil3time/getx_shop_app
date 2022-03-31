import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/cart_item_model.dart';
import '../../../model/order_model.dart';

class OrderController extends GetxController {
  final RxList<OrderItem> _orders = <OrderItem>[].obs;

  List<OrderItem> get orders {
    return [..._orders];
  }

  var isLoading = false.obs;
  toogleIsLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<void> httpPostOrder(
      List<CartItem> cartItems, double totalAmount, ) async {
    if (totalAmount == 0 || isLoading.value) {
      null;
    } else {
      toogleIsLoading();

      final timeStamp = DateTime.now();
      final url = Uri.parse(
          'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
      final response = await http.post(
        url,
        body: json.encode(
          {
            'amount': totalAmount,
            'dateTime': timeStamp.toIso8601String(),

            'orderProducts': cartItems
                .map((cartItem) => {
                      'id': cartItem.id,
                      'itemName': cartItem.itemName,
                      'imageUrl': cartItem.imageUrl,
                      'price': cartItem.price,
                      'quantity': cartItem.quantity.value,
                    })
                .toList(),
          },
        ),
      );

      _orders.insert(
          0,
          OrderItem(
              detailsShown: false,
              amount: totalAmount,
              dateTime: DateTime.now(),
              id: await json.decode(response.body)['name'],
              orderProducts: cartItems));
      toogleIsLoading();
    }
  }

  // void addOrders(List<CartItem> cartItems, double totalAmount) {
  //   if (totalAmount == 0) {
  //     null;
  //   } else {
  //     _orders.insert(
  //         0,
  //         OrderItem(
  //             amount: totalAmount,
  //             dateTime: DateTime.now(),
  //             id: DateTime.now().toString(),
  //             orderProducts: cartItems));
  //   }
  // }

  Future<void> httpFethOrders() async {
  
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final dataBase = await http.get(url);

    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;

    if (decodedData == null ) {
      return;
    }
    List<OrderItem> decodedOrders = [];
    decodedData.forEach((orderId, orderItem) {
      decodedOrders.add(OrderItem(

          amount: orderItem['amount'],
          dateTime: DateTime.parse(orderItem['dateTime']),
          id: orderId,
          orderProducts: (orderItem['orderProducts'] as List<dynamic>)
              .map(
                (e) => CartItem(
                  id: e['id'],
                  itemName: e['itemName'],
                  imageUrl: e['imageUrl'],
                  price: e['price'],
                  quantity: RxInt(e['quantity']),
                ),
              )
              .toList()));
    });
    _orders.value = decodedOrders.reversed.toList();
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
