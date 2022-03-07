import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/home_screen_view.dart';
import 'package:getx_shop_app/app/modules/home/views/order_screen_view.dart';
import 'package:getx_shop_app/app/modules/home/views/product_manager_screen_view.dart';

class AppBarDrawer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white12,
      child: Container(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black12,
              title: Text(
                'Orders',
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 22),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.shop_2,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Continue shoping',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comfortaa',
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            Divider(
              color: Colors.white24,
              thickness: 3,
              endIndent: 30,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.send,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Orders',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comfortaa',
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Get.to(OrderScreenView());
              },
            ),
            Divider(
              color: Colors.white24,
              thickness: 3,
              endIndent: 30,
              height: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.manage_accounts,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Product manager',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comfortaa',
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Get.to(ProductManagerScreenView());
              },
            ),
            Divider(
              color: Colors.white24,
              thickness: 3,
              endIndent: 30,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
