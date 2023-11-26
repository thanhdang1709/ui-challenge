import 'package:flutter/material.dart';
import 'package:flutter_app/bindings/splash_binding.dart';
import 'package:flutter_app/routes/page.dart';
import 'package:flutter_app/routes/route.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: Routes.splash,
      smartManagement: SmartManagement.full,
      getPages: AppPages.pages,
      initialBinding: SplashBinding(),
      title: 'V-Tech App',
      debugShowCheckedModeBanner: false,
    ),
  );
}
