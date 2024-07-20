import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/controllers/user_controller.dart';
import '../../../common/widgets/shimmers/shimmer.dart';
import '../../../common/widgets/support/styling.dart';
import '../../../utils/constants/colors.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: TColors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: controller.user.value.profile??'https://i.postimg.cc/7LBygY8x/user.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const TShimmerEffect(width: 40, height: 40),
                  errorWidget: (context, url, error) => const Icon(Icons.error_rounded),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    "${controller.user.value.firstName} ${controller.user.value.lastName}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Grab your favourite meal',
                  style: TStyle.lightText(),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: TColors.warning.withOpacity(0.7),
          ),
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Iconsax.notification,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
