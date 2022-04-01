import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_shop_app/app/modules/home/controllers/autch_controller.dart';
import 'package:getx_shop_app/app/modules/home/views/home_screen_view.dart';

import 'app/bindings/controller_bindings.dart';
import 'app/modules/home/views/auth_screen.dart';
import 'app/routes/app_pages.dart';

void main() {
  final authController = Get.put(AutchController());

  runApp(
    GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: "Application",
      home: authController.isAutch ? HomeScreenView() : AuthScreen(),
      getPages: AppPages.routes,
    ),
  );
}
