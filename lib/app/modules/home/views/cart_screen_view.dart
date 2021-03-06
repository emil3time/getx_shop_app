import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/cart_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/order_screen_view.dart';

import '../../../widgets/cart_products_list.dart';

class CartScreenView extends GetView<CartController> {
  var orderController = Get.put<OrderController>(OrderController());

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
                        label: Obx(
                          () => Text(
                            controller.totalOrder.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        )),
                    CustomOrderButton()
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CartProductsList(),
        ],
      ),
    );
  }
}

class CustomOrderButton extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextButton(
          onPressed: () async {
            controller.addOrder(
                controller.order.orderProducts, controller.totalOrder);
                await  controller.httpPostOrder();

            controller.showAddOrderSnackBar();
            controller.removeAllCartItems();
          },
          child: orderController.isLoading.value
              ? CircularProgressIndicator()
              : Text(
                  'Order now',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
        ));
  }
}
