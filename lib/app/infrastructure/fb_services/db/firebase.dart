import 'dart:convert';

import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:http/http.dart' as http;

class RealTimeDataBase {
  Future<dynamic> httpPostProduct(Product product) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    final response = await http.post(url, body: product).catchError((onError) {
      throw onError;
    });
    return response;
  }

  Future<List<Product>> httpFetchProduct(String token) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$token');
    final dataBase = await http.get(url);
    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;

    List<Product> decodedProducts = [];

    if (decodedData != null) {
      decodedData.forEach((prodId, prodValue) {
        final decodedId = prodId.toString();
        var tmpProduct = Product.fromJson(prodValue);
        tmpProduct.id = decodedId;

        decodedProducts.add(tmpProduct);
      });
    }
    return decodedProducts;
  }

  Future<void> toggleIsFavoriteOpt(bool isFavorite, String id,String token) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$token');
    var response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));

    if (response.statusCode >= 400) {
      throw Error();
    }
  }
}
