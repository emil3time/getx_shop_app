import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/cart_item_model.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/cart_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

import '../model/product_model.dart';

class CartProductCard extends GetView<CartController> {
  CartProduct cartProduct;

  CartProductCard({
    required this.cartProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete_forever,
          size: 50,
        ),
      ),
      key: ValueKey(cartProduct.id),
      direction: DismissDirection.endToStart,
       confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                  'Do you want to remove the item from the cart?',
                ),
                actions: <Widget>[
                  MaterialButton(
                    child: Text('No'),
                    onPressed: () {
                      Get.back(result: false);
                    },
                  ),
                  MaterialButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Get.back(result: true);
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
        controller.removeCartItem(
            cartProduct);
      },
      child: Card(
        elevation: 6,
        child: Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                height: 70,
                width: 60,
                child: Image.network(
                  cartProduct.imageUrl,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.itemName,
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                    ),
                    // SizedBox(height: 15,),
                    Text(
                      cartProduct.price.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Text(
                'x ${cartProduct.quantity}',
                style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 60,
                child: Text(
                    '${(cartProduct.quantity * cartProduct.price).toStringAsFixed(2)}'),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}
