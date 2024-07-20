import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for clipboard functionality
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/ProfileScreen/UI/edit_profile_field.dart';
import 'package:quick_foodies/common/widgets/customAlertBox/custom_alert.dart';
import 'package:quick_foodies/controllers/user_controller.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';

import '../../common/widgets/shimmers/shimmer.dart';
import '../../utils/constants/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black54),
        ),
        elevation: 0,
        backgroundColor: TColors.lightGrey,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black54,
            )),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: CachedNetworkImage(
                    imageUrl: controller.user.value.profile ?? '',
                    height: 75,
                    width: 75,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const TShimmerEffect(width: 40, height: 40),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_rounded),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Change Profile Picture",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: TColors.warning.withOpacity(0.5)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Personal Information",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Name :",
                    style: TextStyle(fontSize: 14, color: TColors.darkGrey),
                  ),
                  Text(
                    '${controller.user.value.firstName} ${controller.user.value.lastName}',
                    style: const TextStyle(fontSize: 14, color: TColors.black),
                  ),
                  IconButton(
                    onPressed: () => Get.to(() => const EditProfilefilds()),
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: TColors.black,
                      size: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Email :",
                    style: TextStyle(fontSize: 14, color: TColors.darkGrey),
                  ),
                  Text(
                    controller.user.value.email,
                    style: const TextStyle(fontSize: 14, color: TColors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: TColors.black,
                      size: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Phone :",
                    style: TextStyle(fontSize: 14, color: TColors.darkGrey),
                  ),
                  Text(
                    controller.user.value.phone,
                    style: const TextStyle(fontSize: 14, color: TColors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: TColors.black,
                      size: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "User ID :",
                    style: TextStyle(fontSize: 14, color: TColors.darkGrey),
                  ),
                  Text(
                    controller.user.value.id,
                    style: const TextStyle(fontSize: 14, color: TColors.black),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: controller.user.value.id));
                    },
                    icon: const Icon(
                      Iconsax.copy,
                      color: TColors.black,
                      size: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          text:
                              "Are you sure you want to delete your account?",
                          onCancelPressed: () {
                            Get.back();
                          },
                          onConfirmPressed: () {
                            controller.deleteUser();
                            Get.back();
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: TColors.error.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                      child: Text(
                        'Close Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: TColors.textWhite),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
