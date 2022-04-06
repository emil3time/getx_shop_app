import 'package:flutter/material.dart';
import 'package:getx_shop_app/app/model/order_model.dart';

class CartProductTile extends StatelessWidget {
  const CartProductTile({required this.product});
 final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            product.itemName,
            style: TextStyle(fontSize: 14),
          ),
          Spacer(),
          Text(
            '${product.quantity.toString()} x ${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
