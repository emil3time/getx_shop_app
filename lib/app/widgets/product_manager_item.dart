import 'package:flutter/material.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';

import '../modules/home/controllers/home_controller.dart';
import 'add_edit_product_dialog.dart';
import 'custom_manager_container.dart';

class ProductManagerItem extends GetView<ManagerController> {
  ProductManagerItem({
    required this.productData,
  });

  final homeController = Get.find<HomeController>();

  final Product productData;

  @override
  Widget build(BuildContext context) {
    return CustomManagerContainer(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 60,
            child: Image.network(
              productData.imageUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Wrap(
            direction: Axis.vertical,
            children: [
              Text('${productData.title}  '),
              Text('price:${productData.price}'),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              controller.editProduct(productData);
              Get.defaultDialog(
                  barrierDismissible: false,
                  buttonColor: Colors.red,
                  title: 'Edit product',
                  content: AddEditProductDialog());
            },
            icon: Icon(
              Icons.edit,
              size: 30,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),);
  }
}


