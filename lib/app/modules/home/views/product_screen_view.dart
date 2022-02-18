import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

class ProductScreenWiev extends StatelessWidget {
  late String id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Product singleProduct =
        Get.find<HomeController>().findSingleProductById(id);
    String title = singleProduct.title ;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: Center(
        child: Text(' $title screen view works really well!'),
      ),
    );
  }
}
