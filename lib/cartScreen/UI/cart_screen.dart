import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';
import '../../controllers/cart_controller.dart';
// Import your CartController file

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController=Get.put(CartController());

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        elevation: 0,
        title: const Text(
          "Cart",
          style: TextStyle(color: TColors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => cartController.cartList.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : ListView.builder(
                itemCount: cartController.cartList.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartList[index];
                  return CartProduct(
                    image: product.image,
                    name: product.name,
                    price: product.price,
                    count: product.count,
                  );
                },
              ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: TColors.warning,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Checkout ₹${cartController.cartList.fold(0.0, (sum, item) => sum + item.totalPrice)}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: TColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CartProduct extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final RxInt count;

  const CartProduct({
    super.key,
    required this.name,
    required this.price,
    required this.count,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: 8),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: TColors.lightGrey),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: TColors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.network(
                    image, // Replace with your image URL or product image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      '₹$price',
                      style:
                          const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    ),
                    Obx(
                      () => Text(
                        'Quantity: ${count.value}',
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
