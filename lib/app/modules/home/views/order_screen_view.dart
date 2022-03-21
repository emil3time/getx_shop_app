import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';

import 'package:getx_shop_app/app/widgets/order_card.dart';

class OrderScreenView extends StatelessWidget {
  final controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Current orders'),
      ),
      body: controller.orders.isEmpty
          ? Center(
              child: Text(
                'Currently the order list is empty',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: controller.orders.length,
              itemBuilder: (context, i) {
                return OrderCard(
                  orderItem: controller.orders[i],
                );
              }),
    );
  }
}
