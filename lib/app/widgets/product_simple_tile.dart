import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/views/product_screen_view.dart';

import '../model/product_model.dart';

class ProductSimpleTile extends StatelessWidget {
  String imageUrl;
  String title;
  String id;
  double price;
  ProductSimpleTile(
      {required this.imageUrl,
      required this.title,
      required this.id,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(ProductScreenWiev(),arguments: id  ) ,

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
              imageUrl,
              fit: BoxFit.cover,
            ),
            header: Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                color: Colors.black54,
                child: Text(
                  'price $price zł',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.cyan.shade300,
                onPressed: () {},
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: ''),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.cyan.shade300,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}