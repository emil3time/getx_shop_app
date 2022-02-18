import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/widgets/product_simple_tile.dart';

import '../../../widgets/products_grid_view.dart';
import '../controllers/home_controller.dart';

class HomeScreenView extends GetView<HomeController> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
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
