import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/bindings/controller_bindings.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      /* initialBinding:ControllerBinding(), */
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
