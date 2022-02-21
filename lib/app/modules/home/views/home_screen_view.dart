import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/widgets/app_bar_cart.dart';
import 'package:getx_shop_app/app/widgets/product_simple_tile.dart';

import '../../../widgets/products_grid_view.dart';
import '../controllers/home_controller.dart';

enum FilterSwitch { all, favorite }

class HomeScreenView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (selectedFilter) {
              if (selectedFilter == FilterSwitch.favorite) {
                controller.switchTooFavorites();
              } else {
                controller.switchTooAll();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('all'),
                value: FilterSwitch.all,
              ),
              PopupMenuItem(
                child: Text('favorites'),
                value: FilterSwitch.favorite,
              )
            ],
            icon: Icon(Icons.more_vert),
          ),
          Obx(
            () => AppBarCart(

              cartIcon: Icon(
                Icons.shopping_cart,
              ),
              cartCounter: controller.cartCounter,


            ),
          )
        ],
        title: Text(
          'Shop',
          style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 34,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductsGridView(),
      ),
    );
  }
}
