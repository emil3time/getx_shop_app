import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/cart_item_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

import '../model/product_model.dart';

class CartProductCard extends GetView<HomeController> {
  CartItem cartItem;
  CartProductCard({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        controller.remoweCartItem(
            quantity: cartItem.quantity.value, imageUrl: cartItem.imageUrl);
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
                  cartItem.imageUrl,
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
                      cartItem.itemName,
                      style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
                    ),
                    // SizedBox(height: 15,),
                    Text(
                      cartItem.price.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Text(
                'x ${cartItem.quantity}',
                style: TextStyle(fontSize: 18, fontFamily: 'Comfortaa'),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 60,
                child: Text('${cartItem.quantity * cartItem.price}'),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
