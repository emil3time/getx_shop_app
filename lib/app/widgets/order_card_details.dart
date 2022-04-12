import 'package:flutter/material.dart';

import '../model/order_model.dart';

class OrderCardDetails extends StatelessWidget {
  final CartProduct orderDetails;
  OrderCardDetails({required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListTile(
        leading: Text(
            ' ${orderDetails.itemName}  ${orderDetails.quantity} x ${orderDetails.price}  = ${orderDetails.price * orderDetails.quantity.value}  '),
      ),
    );
  }
}
