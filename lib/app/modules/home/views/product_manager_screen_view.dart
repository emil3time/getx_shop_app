import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/widgets/product_manager_item.dart';

class ProductManagerScreenView extends GetView<HomeController> {
  const ProductManagerScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products manager',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            itemCount: controller.dummyList.length,
            itemBuilder: (_, i) => ProductManagerItem(productData: controller.dummyList[i],),
          ),
        ),
      ),
    );
  }
}
