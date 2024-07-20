import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BottomNavBar/bottom_nav_bar.dart';
import '../utils/popups/full_screen_loader.dart';
import '../utils/popups/loaders.dart';

class UpdateProductController extends GetxController {
  static UpdateProductController get instance => Get.find();

  final _productsRef = FirebaseFirestore.instance.collection('Products');
  // variables
  final id = TextEditingController();
  final image = TextEditingController();
  final productName = TextEditingController();
  final price = TextEditingController();
  final calories = TextEditingController();
  final rating = TextEditingController();
  final description = TextEditingController();
  GlobalKey<FormState> updateForm = GlobalKey<FormState>();

  Future<void> updateProductFields(String productId) async {
    try {
      TFullScreenLoader.openLoadingDialog("We are updating your information", 'assets/loader.json');

      if (!updateForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (productId.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Error", message: "Product ID must be provided");
        return;
      }

      DocumentSnapshot productSnapshot = await _productsRef.doc(productId).get();
      if (!productSnapshot.exists) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Error", message: "Invalid Product ID");
        return;
      }

      Map<String, dynamic> updateProduct = {};
      if (productName.text.trim().isNotEmpty) {
        updateProduct['Name'] = productName.text.trim();
      }
      if (price.text.trim().isNotEmpty) {
        updateProduct['Price'] = price.text.trim();
      }
      if (calories.text.trim().isNotEmpty) {
        updateProduct['Calories'] = calories.text.trim();
      }
      if (rating.text.trim().isNotEmpty) {
        updateProduct['Rating'] = rating.text.trim();
      }
      if (description.text.trim().isNotEmpty) {
        updateProduct['Description'] = description.text.trim();
      }

      if (updateProduct.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Error", message: "No fields to update");
        return;
      }

      await _productsRef.doc(productId).update(updateProduct);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "", message: "Your product information has been updated");
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }
}
