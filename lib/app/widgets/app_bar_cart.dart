import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/views/cart_screen_view.dart';

class AppBarCart extends StatelessWidget {
  Icon cartIcon;
  String cartCounter;
  AppBarCart({required this.cartIcon, required this.cartCounter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: () {
            Get.to(CartScreenView());
          },
          icon: cartIcon,
        ),
        Positioned(
            left: 30,
            bottom: 5,
            child: CircleAvatar(
              backgroundColor: cartCounter == 0.toString()
                  ? Colors.blueAccent
                  : Colors.green,
              radius: 8,
              child: FittedBox(child: Text(cartCounter)),
            ))
      ],
    );
  }
}
