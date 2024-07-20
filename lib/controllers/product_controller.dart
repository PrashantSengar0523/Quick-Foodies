import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:quick_foodies/Models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../BottomNavBar/bottom_nav_bar.dart';
import '../utils/exceptions/firebase_exceptions.dart';
import '../utils/exceptions/platform_exceptions.dart';
import '../utils/popups/full_screen_loader.dart';
import '../utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _productsRef = FirebaseFirestore.instance.collection('Products');

  // Variables
  final id = TextEditingController();
  final image = TextEditingController();
  final productName = TextEditingController();
  final price = TextEditingController();
  final calories = TextEditingController();
  final rating = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();
  GlobalKey<FormState> addForm = GlobalKey<FormState>();
  final productList = <ProductModel>[].obs;
  final isLoading = true.obs;
  var filteredProductList = <ProductModel>[].obs;
  var selectedCategory = 'All'.obs; // Default to 'All'

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _productsRef.get();
      productList.clear();
      for (var doc in snapshot.docs) {
        productList.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      filterProducts(); // Ensure filtered list is updated
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'something went wrong';
    } finally {
      isLoading(false);
    }
  }

  Future<String> uploadImageToStorage(Uint8List imageBytes, String productId) async {
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child('product_images/$productId.jpg');
      UploadTask uploadTask = storageRef.putData(imageBytes);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw 'Image upload failed: $e';
    }
  }

  Future<void> createProduct(Uint8List imageBytes) async {
    try {
      isLoading(true);
      TFullScreenLoader.openLoadingDialog("We are processing your information...", 'assets/docer.json');

      if (!addForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      DocumentReference docRef = _productsRef.doc();
      final productId = docRef.id;

      String imageUrl = await uploadImageToStorage(imageBytes, productId);
      debugPrint("Image URL: $imageUrl");

      final product = ProductModel(
        id: productId,
        image: imageUrl,
        name: productName.text.trim(),
        price: price.text.trim(),
        calories: calories.text.trim(),
        rating: rating.text.trim(),
        description: description.text.trim(),
        category: category.text.trim(),
      );

      await docRef.set(product.toJson());
      await fetchProducts();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: "Your product has been added successfully!",
      );

    } on FirebaseException catch (e) {
      TFullScreenLoader.stopLoading();
      throw TFirebaseException(e.code);
    } on PlatformException catch (e) {
      TFullScreenLoader.stopLoading();
      throw TPlatformException(e.code);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      throw 'Something went wrong';
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      isLoading(true);
      TFullScreenLoader.openLoadingDialog("We are deleting your product...", 'assets/docer.json');

      DocumentSnapshot productSnapshot = await _productsRef.doc(productId).get();
      if (!productSnapshot.exists) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Error", message: "Invalid Product ID");
        return;
      }
      await _productsRef.doc(productId).delete();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "", message: "Product deleted successfully");
      Get.offAll(() => const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  void filterProducts() {
    if (selectedCategory.value == 'All') {
      filteredProductList.value = productList;
    } else {
      filteredProductList.value = productList
          .where((product) => product.category == selectedCategory.value)
          .toList();
    }
  }
}


