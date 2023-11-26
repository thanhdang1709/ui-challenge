import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/controllers/splash_controller.dart';
import 'package:flutter_app/screens/traning/traning.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {},
        shape: const CircleBorder(),
        child: Obx(
          () => controller.isPlaying.value
              ? const Icon(
                  Icons.pause,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.search,
                  color: Colors.red,
                ),
        ),
      ),
      body: Center(
        child: PersistentTabView(
          context,
          // controller: controller.tabController,
          screens: const [
            GraphWidget(),
            GraphWidget(),
            GraphWidget(),
            GraphWidget(),
            GraphWidget(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.model_training_sharp),
              title: ("Training"),
              activeColorPrimary: Colors.indigo,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.search),
              title: ("Search"),
              activeColorPrimary: Colors.indigo,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.add),
              title: ("Add"),
              activeColorPrimary: Colors.indigo,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.message),
              title: ("Messages"),
              activeColorPrimary: Colors.indigo,
              inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.person),
              title: ("Profile"),
              activeColorPrimary: Colors.indigo,
              inactiveColorPrimary: Colors.grey,
            ),
          ],
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          onItemSelected: (index) {
            if (index == 1) {}
          },
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          hideNavigationBarWhenKeyboardShows: true,
          // margin: const EdgeInsets.only(left: 50),
          padding: const NavBarPadding.only(left: 80),
          navBarStyle: NavBarStyle.style6
        ),
      ),
    );
  }
}
