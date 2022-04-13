import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

import '../model/product_model.dart';
import './product_simple_tile.dart';

class ProductsGrid extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // if use stateless Widget first must find controller
    // var controller = Get.put<HomeController>(HomeController());

    return Obx(
      () => GridView.builder(
        itemCount: controller.showOnlyFavorite.value
            ? controller.onlyFavoriteList.length
            : controller.allProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 330,
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, i) => ProductSimpleTile(
            product: controller.showOnlyFavorite.value
                ? controller.onlyFavoriteList[i]
                : controller.allProducts[i]
            ),
      ),
    );
  }
}
