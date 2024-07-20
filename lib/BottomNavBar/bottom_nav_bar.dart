import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/ProfileScreen/UI/setting.dart';
import 'package:quick_foodies/cartScreen/UI/cart_Screen.dart';
import 'package:quick_foodies/favouriteScreen/UI/favourite.dart';

import '../homeScreen/UI/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 60,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            selectedIndex: controller.selectedIndex.value,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: ''),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.heart), label: ''),
              NavigationDestination(
                  icon: Icon(Iconsax.shopping_bag), label: ''),
              NavigationDestination(icon: Icon(Iconsax.setting), label: ''),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const FavouriteScreen(),
    const CartScreen(),
    const SettingScreen()
  ];
}
