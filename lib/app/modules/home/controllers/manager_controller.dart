import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
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

  saveFormKey() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();

    homeController.dummyList.forEach((element) {
      print('${element.id} : ${newProduct.id}');
    });
    if (homeController.dummyList.any((element) => element.id == newProduct.id)) {
      var indexUpdatedProduct =
          homeController.dummyList.indexWhere((element) => element.id == newProduct.id);
      homeController.dummyList[indexUpdatedProduct] = newProduct;
    } else {
      newProduct.id = DateTime.now().toString();
      homeController.dummyList.add(newProduct);
    }
    Get.back();
    clearInitialValue();
  }

  validateFormKey(String value) {
    if (value == null || value.isEmpty) {
      return Text('This field is mandatory');
    }
    return null;
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
