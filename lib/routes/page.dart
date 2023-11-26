import 'package:flutter_app/bindings/home_binding.dart';
import 'package:flutter_app/bindings/splash_binding.dart';
import 'package:flutter_app/routes/route.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/splash/splash_screen.dart';
import 'package:flutter_app/screens/traning/traning.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    ),
  ];
}
