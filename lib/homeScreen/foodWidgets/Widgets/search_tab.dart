import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class SearchFieldTab extends StatelessWidget {
  const SearchFieldTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded( // Expand the TextField to take the remaining width
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: TColors.white,
              border: Border.all(color: TColors.black),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                prefixIcon: Icon(Iconsax.search_status, color: TColors.warning),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10), // Add space between the TextField and the Icon
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: TColors.warning.withOpacity(0.7), // Set the desired opacity here
          ),
          padding: const EdgeInsets.all(8.0), // Adjust padding to control icon size
          child: const Icon(
            Icons.filter_list,
            color: Colors.white,
          ), // Ensure icon color contrasts with background
        ),
      ],
    );
  }
}
