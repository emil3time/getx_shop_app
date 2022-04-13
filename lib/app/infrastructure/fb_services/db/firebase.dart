import 'dart:convert';

import 'package:getx_shop_app/app/model/order_model.dart';
import 'package:getx_shop_app/app/model/product_model.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:http/http.dart' as http;

class RealTimeDataBase {
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

  Future<List<Order>> featchOrders() async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=${authResponse['idToken']}');

    final dataBase = await http.get(url);
    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;

    List<Order> decodedOrders = [];

    if (decodedData != null) {
      decodedData.forEach((orderId, orderValue) {
        var tmpOrder = Order.fromJson(orderValue);
        decodedOrders.add(tmpOrder);
      });
    }
    return decodedOrders;
  }

  Future<http.Response> postProduct(Product product) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authResponse['idToken']}');
    print(productToJson(product));
    /* print('id: ${product.ownerId}'); */

    final response = await http
        .post(url, body: productToJson(product))
        .catchError((onError) {
      print('throw error firebase : $onError');
      throw onError;
    });
    return response;
  }

  Future<List<Product>> featchProduct([bool filterByOwner = false]) async {
    final filterUrl = filterByOwner ? '&orderBy="ownerId"&equalTo="${authResponse['localId']}"' : '';
    var url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authResponse['idToken']}$filterUrl');
    final dataBase = await http.get(url);

    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;

    url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/${authResponse['localId']}.json?auth=${authResponse['idToken']}');

    final jsonIsFavorite = await http.get(url);
    final decodedIsFavorite = jsonDecode(jsonIsFavorite.body);

    List<Product> decodedProducts = [];

    if (decodedData != null) {
      decodedData.forEach((prodId, prodValue) {
        final decodedId = prodId.toString();
        var tmpProduct = Product.fromJson(prodValue);
        tmpProduct.id = decodedId;
        tmpProduct.isFavorite = decodedIsFavorite == null
            ? false
            : decodedIsFavorite[tmpProduct.id] ?? false;

        decodedProducts.add(tmpProduct);
      });
    }
    return decodedProducts;
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
      rethrow;
    }
  }

  Future<http.Response> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=${authResponse['idToken']}');

    var response = await http.delete(url);
    return response;
  }

  Future<void> putIsFavorite(
    bool isFavorite,
    String productId,
  ) async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/${authResponse['localId']}/$productId.json?auth=${authResponse['idToken']}');
    var response = await http.put(url, body: json.encode(isFavorite));

    if (response.statusCode >= 400) {
      throw Error();
    }
  }
}
