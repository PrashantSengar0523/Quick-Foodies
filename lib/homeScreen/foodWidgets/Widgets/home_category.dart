import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';


class TCategories extends StatelessWidget {
  TCategories({
    super.key,
    // required this.categories,
    required this.selectedCategory,
  });
  final categories = ['All', 'Pizza', 'Burgers', 'Salad', 'Desserts', 'Drinks'];
  // final List<String> categories;
  final RxInt selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Adjust the height based on your needs
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedCategory.value = index; // Update selected category index
            },
            child: Obx(() => Container(
              margin: const EdgeInsets.only(right: 10), // Space between categories
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: selectedCategory.value == index ? TColors.warning.withOpacity(0.7) : TColors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: TColors.warning), // Black border
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: selectedCategory.value == index ? TColors.black : TColors.darkGrey, // Adjust text color based on selection
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
