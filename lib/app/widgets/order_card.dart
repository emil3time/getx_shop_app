import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/order_controller.dart';
import 'package:getx_shop_app/app/widgets/order_card_details.dart';
import 'package:intl/intl.dart';

class OrderCard extends GetView<OrderController> {
  final Order orderItem;
  OrderCard({required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      color: Colors.white,

      child: Column(
        children: [
          ListTile(
            title: Text(
              orderItem.amount.toStringAsFixed(2),
            ),
            subtitle: Text(
              DateFormat.yMMMMEEEEd().format(orderItem.dataTime),
            ),
            trailing: GetBuilder<OrderController>(
              builder: (contr) {
                return IconButton(
                  onPressed: () {
                    /* controller.togleShowDetails(orderItem); */
                  },
                  icon: /* orderItem.detailsShown
                      ? Icon(
                          Icons.expand_less,
                        )
                      : */ Icon(
                          Icons.expand_more,
                        ),
                );
              },
            ),
          ),
          /* GetBuilder<OrderController>(
            /* init: controller, */
            builder: (contr) {
              if (orderItem.detailsShown) {
                return Container(
                  color: Colors.white,
                  height: min(orderItem.orderProducts.length * 20 + 10, 100),
                  child: OrderCardDetails(orderItem: orderItem),
                );
              }
              return SizedBox();
            },
          ) */
        ],
      ),
    );
  }
}
