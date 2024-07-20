import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../Models/cart_model.dart';
import '../../../controllers/cart_controller.dart';
import '../../../utils/constants/colors.dart';
import 'add_cart_button.dart';



// ignore: must_be_immutable
class DetailSection extends StatelessWidget {
  DetailSection({
    super.key,
    required this.name,
    required this.price,
    required this.calories,
    required this.rating,
    required this.description,
    required this.image, 
    required this.id,
  });
  final String id;
  final String image;
  final String name;
  final String price;
  final String calories;
  final String rating;
  final String description;

  final RxInt count = 0.obs;
  final cartController = Get.put(CartController());

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  void addToCart() {
    if (count.value > 0) {
      final product = CartModel(
        id: id,
        image: image,
        name: name,
        price: price,
        count: count,
      );
      cartController.addToCart(product);
      Get.snackbar('Added to Cart', '$name added to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
       Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    decrement();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: TColors.warning.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        CupertinoIcons.minus,
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      count.value.toString(),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    increment();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: TColors.warning.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        CupertinoIcons.add,
                        color: TColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '₹$price',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.star_lefthalf_fill,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '$calories kcal',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock_fill,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "21 min",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // Food Description
            const Text(
              "About",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'ID: $id',
                style: const TextStyle(
                  color: TColors.darkerGrey,
                  fontSize: 16,
                ),
              ),
            ),
            ReadMoreText(
              description,
              trimLines: 2,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              style: const TextStyle(color: Colors.black),
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              lessStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: addToCart,
            //   child: const Text("Add to Cart"),
            //   style: ElevatedButton.styleFrom(
            //   ),
            // ),
            AddToCartButton(onTap: () => addToCart(),),
          ],
        ),
      );
    
  }
}
