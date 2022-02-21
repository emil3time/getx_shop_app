import 'package:get/get.dart';

class CartItem {
  String id;
  String itemName;
  String imageUrl;
  double price;
  RxInt quantity = 0.obs;

  CartItem({
    required this.id,
    required this.itemName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
