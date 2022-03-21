import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/order_screen_view.dart';
import 'package:getx_shop_app/app/modules/home/views/product_manager_screen_view.dart';

import 'drawer_widgets.dart';

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
                'Menu',
                style: TextStyle(fontFamily: 'Comfortaa', fontSize: 22),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DrawerItem(
              icon: Icons.shop_two_outlined,
              title: 'Continue shoping',
              goTo: () => Get.back(),
            ),
            DrawerDivider(),
            DrawerItem(icon: Icons.send_outlined,
              title: 'Orders',
              goTo: () => Get.to(OrderScreenView()),
            ),
            DrawerDivider(),
            DrawerItem(
              icon: Icons.manage_accounts_outlined,
              title: 'Product manager',
              goTo: () => Get.to(ProductManagerScreenView()),
            ),
            DrawerDivider(),
          ],
        ),
      ),
    );
  }
}
