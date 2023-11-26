import 'package:flutter_app/bindings/splash_binding.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
