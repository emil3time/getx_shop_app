import 'package:get/get.dart';
import 'autch_controller.dart';

import 'package:getx_shop_app/app/model/product_model.dart';

import '../../../infrastructure/fb_services/db/firebase.dart';

class HomeController extends GetxController {
  RxList<Product> dummyList = <Product>[].obs;
  //fetch product
  Future<void> httpFetchProduct() async {
    dummyList.value = await RealTimeDataBase()
        .featchProduct();
  }

  // RxBool where use switches
  RxBool showOnlyFavorite = false.obs;
  // switch for favorite
  void switchTooFavorites() {
    showOnlyFavorite.value = true;

  }

  // switch for all
  void switchTooAll() {
    showOnlyFavorite.value = false;

  }

  void updateState() {
    update();
  }

  // List of Products marked as favorite
  List<Product> get onlyFavoriteList {
    return dummyList.where((e) => e.isFavorite).toList();
  }

  // create get to chandle private class
/*   List<Product> get dummyList {
    return [..._dummyList];
  } */

// choose between the favorites list and the all list
  List<Product> get favoriteOrAll {
    if (showOnlyFavorite.value) {
      return [...onlyFavoriteList];
    } else {
      return [...dummyList];
    }
  }

// firstWhere list method return first element where condition == true
//
  Product findSingleProductById(String id) {
    return dummyList.firstWhere((e) => e.id == id);
  }

  @override
  void onInit() async {
    await httpFetchProduct();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }
}
