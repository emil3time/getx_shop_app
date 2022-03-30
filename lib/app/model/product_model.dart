import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Product {
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
  Future<void> toggleIsFavoriteOpt(String id) async {
    var savedStatus = isFavorite!.value;
    isFavorite!.value = !isFavorite!.value;
    try {
      final url = Uri.parse(
          'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
      var response = await http.patch(url,
          body: json.encode({'isFavorite': isFavorite!.value}));
      if (response.statusCode >= 400) {
        isFavorite!.value = savedStatus;
      }
    } catch (e) {
      isFavorite!.value = savedStatus;
    }
  }
}

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
