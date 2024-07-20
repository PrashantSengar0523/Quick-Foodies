import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Models/product_model.dart';
import 'package:quick_foodies/controllers/favourite_controller.dart';
import 'package:quick_foodies/favouriteScreen/UI/widgets/prdouct.dart';
import 'package:quick_foodies/homeScreen/UI/food_detail.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key, this.productModel});
  final ProductModel ?productModel;
  @override
  Widget build(BuildContext context) {
    final favController=Get.put(FavouriteController());
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        elevation: 0,
        title: const Text(
          "Favourites",
          style: TextStyle(color: TColors.black),
        ),
        centerTitle: true,
      ),
       body: Obx(() {
        if (favController.favouritList.isEmpty) {
          return Center(
            child: Text(
              'No favorite products',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.xl, vertical: TSizes.sm),
          itemCount: favController.favouritList.length,
          itemBuilder: (context, index) {
            final product = favController.favouritList[index];
            return GestureDetector(
              onTap: () {
                Get.to(()=>FoodDetailScreen(image: product.image, name: product.name, price: product.price, calories: product.calories, rating: product.rating, description: product.description, id: product.id));
              },
              child: Product(product: product)); // Assuming you pass the product to this widget
          },
        );
      }),
    );
  }
}

