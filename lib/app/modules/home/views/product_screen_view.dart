import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';

class ProductScreenWiev extends GetView<HomeController> {
  // reciewe id- use it to find product with the same id in list of Products (dummyList)
  late String id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // if I use stateless widget without binding first must find controler like below
    // Product singleProduct =
    //     Get.find<HomeController>().findSingleProductById(id);
    Product singleProduct = controller.findSingleProductById(id);
    String title = singleProduct.title;
    return Scaffold(
        appBar: AppBar(
          title: Text(id),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: 220,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image.network(
                      singleProduct.imageUrl,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      singleProduct.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      singleProduct.price.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Text(singleProduct.description),
            ),
          ],
        ));
  }
}
