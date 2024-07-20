import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/Models/product_model.dart';
import 'package:quick_foodies/controllers/favourite_controller.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';

import '../../../utils/constants/colors.dart';

class Product extends StatelessWidget {
  const Product({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final favController=Get.put(FavouriteController());
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: TColors.lightContainer,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl:product.image,
                        height: 100,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // const SizedBox( width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.redAccent,
                              size: 12,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${product.calories} Kcal",
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.clock_fill,
                              color: TColors.darkGrey,
                              size: 12,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "21 min",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        
                        Row(
                          children: [
                            const Icon(
                              Icons.star_half_rounded,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              product.rating,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                ),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: TColors.textWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() {
                            return IconButton(
                              onPressed: () {
                                favController.favouritList.remove(product);
                                TLoaders.customToast(message: 'Removed from Wishlist');
                              },
                              icon:Icon(favController.favouritList.contains(product)
                                  ? Iconsax.heart5
                                  : Iconsax.heart,
                              color: TColors.error,
                            ));
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18,)
      ],
    );
  }
}
