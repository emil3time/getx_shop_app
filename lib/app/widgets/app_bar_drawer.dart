import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/home_screen_view.dart';
import 'package:getx_shop_app/app/modules/home/views/order_screen_view.dart';

class AppBarDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            AppBar(
              title: Text('Orders'),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.shop_2,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                'Continue shoping',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.send,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                'Orders',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Get.to(OrderScreenView());
              },
            )
          ],
        ),
      ),
    );
  }
}
