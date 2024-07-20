
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/BottomNavBar/bottom_nav_bar.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';


class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Row(
        children: [
          Material(
            color: TColors.white.withOpacity(0.21),
            borderRadius: BorderRadius.circular(12),
            child: BackButton(
              onPressed: () {
                Get.to(() => const NavigationMenu());
              },
              color: TColors.white,
            ),
          ),
          const Spacer(),
          const Text(
            'Food Detail',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21,
                color: TColors.white),
          ),
          const Spacer(),
          Material(
            color: TColors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 38,
                width: 38,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.share,
                  color: TColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
