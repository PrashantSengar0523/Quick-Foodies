import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/controllers/favourite_controller.dart';
import 'package:quick_foodies/controllers/product_controller.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';

import '../../../common/widgets/shimmers/shimmer.dart';
import '../../../utils/constants/colors.dart';
import '../../UI/food_detail.dart';

class ItemsDisplay extends StatelessWidget {
  const ItemsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final favController = Get.put(FavouriteController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const TShimmerEffect(
          width: double.infinity,
          height: 1000,
        );
      }
      if (controller.productList.isEmpty) {
        return Center(
          child: Text(
            'No products available',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        itemCount: controller.productList.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          mainAxisExtent: 262,
        ),
        itemBuilder: (context, index) {
          final food = controller.productList[index];
          return Container(
            height: 205,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3.5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => FoodDetailScreen(
                          id: food.id,
                          image: food.image,
                          name: food.name,
                          price: food.price,
                          rating: food.rating,
                          calories: food.calories,
                          description: food.description,
                        ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Center(
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(120),
                          child: CachedNetworkImage(
                            imageUrl: food.image,
                            width: 200, // Adjust width as needed
                            height: 130, // Adjust height as needed
                            fit: BoxFit.cover, // Adjust fit as needed
                            placeholder: (context, url) =>
                                const TShimmerEffect(width: 100, height: 100),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              '${food.calories} kcal',
                              style: const TextStyle(color: Colors.black38),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star_half_rounded,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 9),
                            Text(
                              food.rating,
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${food.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                        color: TColors.lightGrey,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            bool isFavorite =
                                favController.favouritList.contains(food);

                            // Toggle favorite status
                            favController.toggleFavorite(food);

                            // Show appropriate toast message
                            String message = isFavorite
                                ? 'Removed from WishList'
                                : 'Added to WishList';
                            TLoaders.customToast(message: message);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Obx(() {
                              return Icon(
                                favController.favouritList.contains(food)
                                    ? Iconsax.heart5
                                    : Iconsax.heart,
                                color: TColors.error,
                              );
                            }),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
