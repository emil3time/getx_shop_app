import 'dart:convert';

/*   import 'package:get/get.dart';
  import 'package:getx_shop_app/app/model/http_exeption_model.dart';
  import 'package:http/http.dart' as http; */

import 'package:getx_shop_app/app/infrastructure/fb_services/db/firebase.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
    required this.price,
    required this.title,
    this.id,
    this.isInCart = false,
    required this.ownerId
  });

  String description;
  String imageUrl;
  bool isFavorite;
  double price;
  String title;
  String? id;
  bool isInCart;
  String ownerId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        description: json["description"],
        imageUrl: json["imageUrl"],
        // isFavorite: json["isFavorite"],
        price: double.parse(json["price"]),
        title: json["title"],
        ownerId: json["ownerId"]
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "imageUrl": imageUrl,
        // "isFavorite": isFavorite,
        "price": price.toString(),
        "title": title,
        "ownerId": ownerId
      };

  Future<void> toggleFavoriteFirebase() async {
    await RealTimeDataBase().putIsFavorite(
      isFavorite,
      id ?? '',
    );
  }
}






























/* class Product {
  String? id;
  String title;
  String description;
  String imageUrl;
  double price;
  RxBool? isFavorite = false.obs;

  Product({
    required this.description,
    this.id,
    this.isFavorite,
    required this.title,
    required this.imageUrl,
    required this.price,
  });

} */

// Future<void> isFavoriteUpdate(String id) async {
//   final index =
//       homeController.dummyList.indexWhere((element) => element.id == id);
//   var isFavoriteOpt = homeController.dummyList[index].isFavorite;

//   final url = Uri.parse(
//       'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/');
//   var response = await http.patch(url,
//       body: json.encode(
//           {'isFavorite': homeController.dummyList[index].isFavorite.value}));
//   if (response.statusCode >= 400) {
//     homeController.dummyList[index].isFavorite = isFavoriteOpt;
//     print(response.statusCode);
//     throw HttpExeption(message: 'fail  ');
//   }
//   isFavoriteOpt.isBlank;
// }
