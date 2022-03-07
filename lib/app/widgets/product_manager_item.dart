import 'package:flutter/material.dart';
import 'package:getx_shop_app/app/model/product_model.dart';

class ProductManagerItem extends StatelessWidget {
  Product productData;
  ProductManagerItem({
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(7),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.amber,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 4,
            offset: Offset(2, 6), // Shadow position
          ),
        ],
        // gradient:
        //     LinearGradient(colors: [Colors.indigo, Colors.blueAccent]),
      ),
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
            Wrap(direction:Axis.vertical ,
              children: [
                Text('${productData.title}  '),
                Text('price:${productData.price}'),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
    );
  }
}
