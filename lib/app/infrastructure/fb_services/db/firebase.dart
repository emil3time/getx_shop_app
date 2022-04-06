import 'dart:convert';

import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:http/http.dart' as http;

class RealTimeDataBase {
  Future<List<Order>> featchOrders(String token, String id) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$token');

    final dataBase = await http.get(url);
    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;

    List<Order> decodedOrders = [];
    int iterator = 1;
    if (decodedData != null) {
      decodedData.forEach((orderId, orderValue) {
        var tmpOrderId = orderId.toString();
        var tmpOrder = Order.fromJson(orderValue);
        decodedOrders.add(tmpOrder);
      });
    }
    return decodedOrders;
  }

  Future<void> toggleIsFavoriteOpt(bool isFavorite, String id) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=${authResponse['idToken']}');
    var response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));

    if (response.statusCode >= 400) {
      throw Error();
    }
  }

  Future<dynamic> postOrder(
    Order order,
  ) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=${authResponse['idToken']}');
    final response = await http.post(
      url,
      body: orderToJson(order),
    );
    return response;
  }

  Future<List<Product>> featchProduct() async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authResponse['idToken']}');
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

  Future<http.Response> postProduct(Product product) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authResponse['idToken']}');
    final response = await http
        .post(url, body: productToJson(product))
        .catchError((onError) {
      throw onError;
    });
    return response;
  }

  Future<dynamic> updateProduct(Product product) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/${product.id}.json?auth=${authResponse['idToken']}');
    late http.Response response;
    try {
      response = await http.patch(
        url,
        body: productToJson(product),
      );
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<http.Response> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=${authResponse['idToken']}');

    var response = await http.delete(url);
    return response;
  }
}
