import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/order_screen_view.dart';
import 'package:getx_shop_app/app/modules/home/views/product_manager_screen_view.dart';

import 'drawer_widgets.dart';

class AppBarDrawer extends GetView<HomeController> {
  var authController = Get.find<AutchController>();
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
                'Menu',
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 22),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DrawerItem(
              icon: Icons.shop_two_rounded,
              title: 'Continue shoping',
              goTo: () => Get.back(),
            ),
            DrawerDivider(),
            DrawerItem(icon: Icons.send_rounded,
              title: 'Orders',
              goTo: () => Get.to(OrderScreenView()),
            ),
            DrawerDivider(),
            DrawerItem(
              icon: Icons.manage_accounts_rounded,
              title: 'Product manager',
              goTo: () => Get.to(ProductManagerScreenView()),
            ),
            DrawerDivider(),
             DrawerItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              goTo: () => authController.logout(),
            ),
            DrawerDivider(),
          ],
        ),
      ),
    );
  }
}
