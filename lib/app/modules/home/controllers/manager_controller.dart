import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/infrastructure/fb_services/db/firebase.dart';
import 'package:getx_shop_app/app/model/http_exeption_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getx_shop_app/app/modules/home/controllers/home_controller.dart';
import '../../../model/product_model.dart';

class ManagerController extends GetxController {
  var db = RealTimeDataBase();
  var homeController = Get.put(HomeController());

  TextEditingController imageUrlController = TextEditingController();

  var formKey = GlobalKey<FormState>();

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

  Future<dynamic> postProduct() async {
    var response = db.postProduct(newProduct);
    return response;
  }

  // update product on database
  var newProduct = Product(
    description: '',
    id: '',
    title: '',
    imageUrl: '',
    price: 0.0,
  );

  Future<dynamic> updateProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    toogleIsLoading();

    try {
      if (homeController.dummyList
          .any((element) => element.id == newProduct.id)) {
        await db.updateProduct(newProduct).then((_) {
          var indexUpdatedProduct = homeController.dummyList
              .indexWhere((element) => element.id == newProduct.id);
          homeController.dummyList[indexUpdatedProduct] = newProduct;
        });
      } else {
        await db.postProduct(newProduct).then((jsonResponse) {
          var response = jsonDecode(jsonResponse.body);

          newProduct.id = response['name'];
          homeController.dummyList.add(newProduct);
        });
      }
    } catch (error) {
      print('catch error upda controller');
      toogleIsLoading();
      showCustomErrorDialog();
      /* toogleIsLoading(); */
    } finally {
      toogleIsLoading();
      clearInitialValue();

      Get.back();
    }
  }

  clearInitialValue() {
    newProduct =
        Product(description: '', id: '', title: '', imageUrl: '', price: 0.0);
    imageUrlController.text = '';
  }

  // Validation
  validateFormKey(String value) {
    if (value.isEmpty) {
      return Text('This field is mandatory');
    }
    return null;
  }

  Future<void> httpUpdate() async {
    db.updateProduct(newProduct);
  }

  // editProduct(Product productData) {
  //   newProduct = productData;
  //   imageUrlController.text = newProduct.imageUrl;
  // }

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

  Future<void> deleteProductOptimistic(String id) async {
    final selectedProductIndex =
        homeController.dummyList.indexWhere((element) => element.id == id);

    var selectedProduct = homeController.dummyList[selectedProductIndex];
    final jsonResponse = await db.deleteProduct(id);
    homeController.dummyList.remove(selectedProduct);

    if (jsonResponse.statusCode >= 400) {
      homeController.dummyList.insert(selectedProductIndex, selectedProduct);

      throw HttpExeption(message: 'delete fail  ');
    }
   
  }

  /*  deleteProduct(String id) {
    final url = Uri.parse(
        'https://fluttermedia-5f19e-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    http.delete(url);

    homeController.dummyList.removeWhere((element) => element.id == id);
  } */

  @override
  void onInit() async {
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
