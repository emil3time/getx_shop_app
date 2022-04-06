// To parse this JSON data, do
//
// final order = orderFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.amount,
    required this.dataTime,
    /* required this.id, */
    required this.orderProducts,
  });

  double amount;
  DateTime dataTime;
  RxList<CartProduct> orderProducts;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      amount: json["amount"],
      dataTime:DateTime.now(),//DateTime.parse(json["dataTime"])
      orderProducts: RxList<CartProduct>.from(
          json["orderProducts"].map((x) => CartProduct.fromJson(x))),
    );
  }

  final tmpTimeStamp = DateTime.now();
  Map<String, dynamic> toJson() => {
        "amount": amount,
        "dataTime": tmpTimeStamp.toIso8601String(),
        "orderProducts":
            List<dynamic>.from(orderProducts.map((x) => x.toJson())),
      };
}

class CartProduct {
  CartProduct({
    required this.id,
    required this.itemName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  String id;
  String itemName;
  String imageUrl;
  double price;
  RxInt quantity;

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json["id"],
      itemName: json["itemName"],
      imageUrl: json["imageUrl"],
      price:  double.parse(json["price"])  ,
      quantity: RxInt(json["quantity"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "imageUrl": imageUrl,
        "price": price.toString(),
        "quantity": quantity.value,
      };
}































/* class OrderItem {
  String id;
  DateTime dateTime;
  double amount;
  List<CartItem> orderProducts;
  bool detailsShown;

  OrderItem(
      {required this.amount,
      required this.dateTime,
      required this.id,
      required this.orderProducts,
       this.detailsShown = false,
      });
}
 */