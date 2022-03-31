import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/model/http_exeption_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import '../../../model/product_model.dart';

class ManagerController extends GetxController {
  var homeController = Get.put(HomeController());

  TextEditingController imageUrlController = TextEditingController();

  FocusNode urlFocusNode = FocusNode();
  String url = '';

  updateUrlController() {
    url = imageUrlController.text;
    update();
  }

  updateImage() {
    if (!urlFocusNode.hasFocus) {
      update();
    }
  }

  updateOnEditingComplete() {
    update();
  }

  /// add edit product
  ///
  var formKey = GlobalKey<FormState>();
  // post probuct
  Future<dynamic> httpPostProduct() async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    final response = await http
        .post(url,
            body: json.encode({
              'title': newProduct.title,
              'price': newProduct.price.toString(),
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'isFavorite': newProduct.isFavorite!.value,
            }))
        .catchError((onError) {
      throw onError;
    });
    return response;
  }

  //fetch product
  Future<void> httpFetchProduct() async {
   
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products.json');
    final dataBase = await http.get(url);
    // print(dataBase.body.toString());
    List<Product> decodedProducts = [];
    final decodedData = json.decode(dataBase.body) as Map<String, dynamic>?;
    if (decodedData == null) {
      return;
    }
    decodedData.forEach((prodId, prodValue) {
      final decodedId = prodId.toString();
      var decodedProduct = Product(
        id: decodedId,
        description: prodValue['description'],
        title: prodValue['title'],
        imageUrl: prodValue['imageUrl'],
        price: double.parse(prodValue['price']),
        isFavorite: RxBool(prodValue['isFavorite']),
      );
      decodedProducts.add(decodedProduct);
    });
    homeController.dummyList.value = decodedProducts;
  }

  // update product on database

  Future<void> httpUpdate() async {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/${newProduct.id}.json');
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'price': newProduct.price.toString(),
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'isFavorite': newProduct.isFavorite!.value,
        }));
  }

  // Progress Indicator
  var isLoading = false.obs;
  toogleIsLoading() {
    isLoading.value = !isLoading.value;
  }

  showCustomErrorDialog() {
    Future.delayed(Duration(milliseconds: 600)).then((_) => Get.defaultDialog(
            actions: <Widget>[
              MaterialButton(
                onPressed: (() => Get.back()),
                child: Text('ok'),
                color: Colors.blue.shade100,
              )
            ],
            barrierDismissible: false,
            title: 'Error',
            content: Container(
              height: 200,
              width: 300,
              child: Center(
                  child: Text(
                      'There is a problem with the connection - try again later  ')),
            )));
  }

// add / update product
  Future<dynamic> manageProduct() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    toogleIsLoading();

    try {
      // check if the product already exists
      if (homeController.dummyList
          .any((element) => element.id == newProduct.id)) {
        // update localy on device
        var indexUpdatedProduct = homeController.dummyList
            .indexWhere((element) => element.id == newProduct.id);
        homeController.dummyList[indexUpdatedProduct] = newProduct;
        // update on Database
        await httpUpdate();
      } else {
        /// adding a new product
        var response = await httpPostProduct();
        newProduct.id = await json.decode(response.body)['name'];

        homeController.dummyList.add(newProduct);
      }
    } catch (error) {
      toogleIsLoading();
      showCustomErrorDialog();
      toogleIsLoading();
    } finally {
      toogleIsLoading();

      clearInitialValue();

      Get.back();
    }
  }

  // Validation
  validateFormKey(String value) {
    if (value.isEmpty) {
      return Text('This field is mandatory');
    }
    return null;
  }

// delete product
  Future<void> deleteProductOptimistic(String id) async {
    final selectedProductIndex =
        homeController.dummyList.indexWhere((element) => element.id == id);

    var selectedProduct = homeController.dummyList[selectedProductIndex];
    homeController.dummyList.remove(selectedProduct);

    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');

    var response = await http.delete(url);
    if (response.statusCode >= 400) {
      homeController.dummyList.insert(selectedProductIndex, selectedProduct);
      print(response.statusCode);
      throw HttpExeption(message: 'delete fail  ');
    }
    selectedProduct.isBlank;
  }

  deleteProduct(String id) {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    http.delete(url);

    homeController.dummyList.removeWhere((element) => element.id == id);
  }

  var newProduct = Product(
    description: '',
    id: '',
    title: '',
    imageUrl: '',
    price: 0.0,
  );

  /*  var initialValues =
    Product(
        description: '',
        id: '',
        title: '',
        imageUrl: '',
        price: 0.0)
    /* 'title': '',
    'description': '',
    'id': '',
    'imageUrl': '',
    'price': '', */
  ; */

  editProduct(Product productData) {
    newProduct = productData;
    imageUrlController.text = newProduct.imageUrl;
  }

  /* managerController.imageUrlController.text = productData.imageUrl; */

  /*  var existingProduct = updateIfProductExist(productData.id); */

  /* Product updateIfProductExist(String id) {
    return dummyList.firstWhere((e) => e.id == id);
  } */

  clearInitialValue() {
    newProduct =
        Product(description: '', id: '', title: '', imageUrl: '', price: 0.0);
    imageUrlController.text = '';
  }

  @override
  void onInit() {
    urlFocusNode.addListener(updateImage);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    urlFocusNode.removeListener(updateImage);

    imageUrlController.dispose();
    super.onClose();
  }
}
