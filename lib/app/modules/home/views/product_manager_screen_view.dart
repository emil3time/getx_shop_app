import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';
import 'package:getx_shop_app/app/widgets/product_manager_item.dart';

import '../../../widgets/add_edit_product_dialog.dart';

class ProductManagerScreenView extends StatelessWidget {
  ProductManagerScreenView({Key? key}) : super(key: key);

  final controller = Get.put(ManagerController());
  final homeController = Get.find<HomeController>();

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
            onPressed: () {
              Get.defaultDialog(
                  title: 'Add new product', content: AddEditProductDialog(existingProduct: controller.newProduct,));
            },
            icon: Icon(
              Icons.add,
              size: 33,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => homeController.httpFetchProduct(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Obx(() => ListView.builder(
                  itemCount: homeController.dummyList.length,
                  itemBuilder: (_, i) => ProductManagerItem(
                    productData: homeController.dummyList[i],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
