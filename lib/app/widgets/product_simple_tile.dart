import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/cart_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import 'package:getx_shop_app/app/modules/home/controllers/manager_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/product_screen_view.dart';

import '../model/product_model.dart';

class ProductSimpleTile extends GetView<HomeController> {
  var cartController = Get.put(CartController());
  var managerController = Get.put(ManagerController());

  Product product;
  ProductSimpleTile({required this.product});

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
            child: Hero(
              tag: product.imageUrl,
              child: FadeInImage(
                fadeInCurve: Curves.slowMiddle,
                fadeInDuration: Duration(seconds: 1),
                placeholder: AssetImage('assets/images/placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
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
                leading: GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) => IconButton(
                          icon: Icon(Icons.favorite),
                          color: product.isFavorite ? Colors.red : Colors.white,
                          onPressed: () async {
                            product.isFavorite = !product.isFavorite;
                            try {
                              await product
                                  .toggleFavoriteFirebase()
                                  .then((value) => controller.updateState());
                            } catch (_) {
                              Get.snackbar('Error', 'status change fail',
                                  duration: Duration(seconds: 1),
                                  shouldIconPulse: true,
                                  icon: Icon(Icons.warning));
                            }
                          },
                        )),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    product.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontFamily: ''),
                  ),
                ),
                trailing: Obx(() => IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: cartController.order.orderProducts
                              .any((element) => element.id == product.id)
                          ? Colors.green
                          : Colors.white,
                      onPressed: () {
                        cartController.addCartItem(CartProduct(
                            id: product.id!,
                            itemName: product.title,
                            imageUrl: product.imageUrl,
                            price: product.price,
                            quantity: 1.obs));

                        Get.snackbar('Cart info', 'added a product to the cart',
                            icon: Icon(Icons.add_shopping_cart),
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 1));
                      },
                    ))),
          ),
        ),
      ),
    );
  }
}
