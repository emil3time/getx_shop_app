import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/cart_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/product_screen_view.dart';

import '../model/product_model.dart';

class ProductSimpleTile extends GetView<HomeController> {
  var cartController = Get.find<CartController>();
  

  Product product;
  ProductSimpleTile(
      {

      required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // here I send id of single product - thanks to this id i can search the whole list of Products provided //by the GetX  HomeController
      onTap: () => Get.to(ProductScreenWiev(), arguments: product.id),

      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 4,
              offset: Offset(2, 6), // Shadow position
            ),
          ],
          // gradient:
          //     LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            header: Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                color: Colors.black54,
                child: Text(
                  'price ${product.price} zł',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Obx(() {
                // print('product isfvorite ${product.isFavorite.value}');
                return IconButton(
                  icon: Icon(Icons.favorite),
                  color: product.isFavorite.value ? Colors.red : Colors.white,
                  onPressed: () {
                    product.toggleIsFavorite();
                  },
                );
              }),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: ''),
                ),
              ),
              trailing: Obx(
                (() => IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: cartController.cartMap.containsKey(product.id)
                          ? Colors.green
                          : Colors.white,
                      onPressed: () {
                        cartController.addCartItem(product.id ?? '', product.price,
                            product.title, product.imageUrl);

                        Get.back();

                        Get.snackbar('Cart info', 'added a product to the cart',
                            icon: Icon(Icons.add_shopping_cart),
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 1));
                      },
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
