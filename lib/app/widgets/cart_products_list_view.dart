import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/widgets/cart_product_card.dart';

class CartProductsListView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      height: 400,
      width: 380,
      child: ListView.builder(
        itemCount: controller.cartMap.length,
        itemBuilder: (context, i) {
          return CartProductCard(
            cartItem: controller.cartMap.values.toList()[i],

            // imageUrl: controller.cartMap.values.toList()[i].imageUrl,
          );
        },
      ),
    );
  }
}
