import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/homeScreen/UI/food_detail.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';
import '../../common/widgets/shimmers/shimmer.dart';
import '../../common/widgets/support/styling.dart';
import '../../controllers/favourite_controller.dart';
import '../../controllers/product_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/popups/loaders.dart';

import '../foodWidgets/Widgets/home_top_bar.dart';

import '../foodWidgets/Widgets/search_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final favController = Get.put(FavouriteController());
    final categories = [
      'All',
      'Pizza',
      'Burgers',
      'Salad',
      'Desserts',
      'Drinks'
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeTopBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Search Field
                  const SearchFieldTab(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Categories
                  const TText(text: 'Categories'),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.updateCategory(categories[index]);
                          },
                          child: Obx(() => Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  color: controller.selectedCategory.value == categories[index]
                                      ? TColors.warning.withOpacity(0.7)
                                      : TColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: TColors.warning),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: controller.selectedCategory.value == categories[index]
                                          ? TColors.black
                                          : TColors.darkGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
           
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                  child: TText(text: 'Food for you'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const TShimmerEffect(
                      width: double.infinity,
                      height: 1000,
                    );
                  }
                  if (controller.filteredProductList.isEmpty) {
                    return Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.filteredProductList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 262,
                    ),
                    itemBuilder: (context, index) {
                      final food = controller.filteredProductList[index];
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
                                      child: CachedNetworkImage(
                                        imageUrl: food.image,
                                        width: 200,
                                        height: 130,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const TShimmerEffect(width: 100, height: 100),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                        bool isFavorite = favController
                                            .favouritList
                                            .contains(food);

                                        favController.toggleFavorite(food);

                                        String message = isFavorite
                                            ? 'Removed from WishList'
                                            : 'Added to WishList';
                                        TLoaders.customToast(message: message);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Obx(() {
                                          return Icon(
                                            favController.favouritList
                                                    .contains(food)
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
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
