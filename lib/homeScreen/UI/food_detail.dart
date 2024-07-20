import 'package:flutter/material.dart';
import 'package:quick_foodies/utils/constants/colors.dart';


import 'food_detail_widget/detail.dart';
import 'food_detail_widget/header.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key, required this.image, required this.name, required this.price, required this.calories, required this.rating, required this.description, required this.id});
  final String id;
  final String image;
  final String name;
  final String price;
  final String calories;
  final String rating;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      body: ListView(
        children: [
          FoodDetailHeader(image: image,),
          DetailSection(name: name,price: price,rating: rating,calories: calories,description: description,id: id,image: image,)
        ],
      ),
      // bottomNavigationBar: const AddToCartButton()
      );
  }
}

