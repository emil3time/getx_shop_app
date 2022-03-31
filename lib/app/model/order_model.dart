import 'package:getx_shop_app/app/model/cart_item_model.dart';

class OrderItem {
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
