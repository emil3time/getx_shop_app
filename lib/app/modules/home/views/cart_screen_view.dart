import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

import '../../../widgets/cart_products_list_view.dart';

class CartScreenView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total amount:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.green,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Text(
                          'ZŁ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      label:Obx(()=> Text(
                        controller.totalAmt.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ), )
                    ),
                    TextButton(
                      onPressed: (){ },
                      child: Text(
                        'Order now',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),

            ),
            ),
          ),
        SizedBox(
          height: 50,
        ),
        CartProductsListView(),
        ],
      ),
    );
  }
}
