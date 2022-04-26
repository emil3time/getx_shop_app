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
    Product product = controller.findSingleProductById(id);

    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.imageUrl,
                child: Image.network(
                  product.imageUrl,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height:50,
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.price.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(product.description),
            ),
            SizedBox(
              height: 700,
            ),
            Text('naskjhdjkashdjksajkdjkasbdjhkasbjhkdbhj')
          ]))
        ],
      ),
    );
  }
}
