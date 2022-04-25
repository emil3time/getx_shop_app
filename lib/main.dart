import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/home_screen_view.dart';

import 'app/bindings/controller_bindings.dart';
import 'app/controllers/global_controller.dart';
import 'app/modules/home/views/auth_screen.dart';
import 'app/routes/app_pages.dart';

void main()async {
  await GetStorage.init();
  final authController = Get.put(AutchController());
  final globalcontroller = Get.put(GlobalController());



  runApp(
    Obx(
      ()=> GetMaterialApp(
        initialBinding: ControllerBinding(),
        title: "Application",
        home:  authController.isAutch.value ? HomeScreenView() : AuthScreen(),
        getPages: AppPages.routes,
      ),
    ),
  );
}
