import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Models/cart_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  final cartbox = GetStorage();
  final cartList = <CartModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    loadCartProducts();
  }

  void addToCart(CartModel product) {
    // Check if product already exists in the cart
    int existingIndex = cartList.indexWhere((item) => item.id == product.id);
    if (existingIndex != -1) {
      cartList.removeAt(existingIndex);
    } else {
      cartList.add(product);
    }
    // saveCartProduct();
  }

  void saveCartProduct() {
    
      // Convert cartList to a list of maps
      List<Map<String, dynamic>> ctList = cartList.map((products) => products.toJson()).toList();
      cartbox.writeIfNull('cartes', ctList);
    
  }

  void loadCartProducts() {
    try {
      // Read the data from GetStorage
      List<dynamic> ctList = cartbox.read<List<dynamic>>('cartes') ?? [];
      cartList.assignAll(ctList.map((e) => CartModel.fromMap(e)).toList());
    } catch (e) {
      // Handle any errors during the load process
      debugPrint("Error loading cart products: $e");
    }
  }
}
