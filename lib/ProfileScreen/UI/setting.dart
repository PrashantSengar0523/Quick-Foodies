import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/ProfileScreen/UI/edit_profile.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/common/widgets/customAlertBox/custom_alert.dart';
import 'package:quick_foodies/controllers/user_controller.dart';
import 'package:quick_foodies/uploads/UI/update.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import '../../common/widgets/shimmers/shimmer.dart';
import '../../uploads/UI/add.dart';
import '../../utils/constants/sizes.dart';
import 'widgets/setting_detail.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthenticationRepo());
    final userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: TColors.lightGrey,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.xl),
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(11),
                      color: TColors.grey, // Set the desired opacity here
                    ), // Adjust padding to control icon size
                    child: ClipRRect(
                      child: CachedNetworkImage(
                          imageUrl: userController.user.value.profile ?? '',
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const TShimmerEffect(width: 40, height: 40),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error_rounded)),
                    ) // Ensure icon color contrasts with background
                    ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${userController.user.value.firstName} ${userController.user.value.lastName}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: TColors.darkerGrey,
                  ),
                ),

                Text(
                  userController.user.value.email,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      // fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: TColors.darkGrey),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const EditProfile()),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: TColors.warning,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                      child: Text(
                        'Edit profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            // fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: TColors.textWhite),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SettingDetailBar(
                  icon: CupertinoIcons.app_badge_fill,
                  text: 'Order history',
                  subText: 'Track your orders within Dates',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SettingDetailBar(
                  icon: CupertinoIcons.location_solid,
                  text: 'Addresses',
                  subText: 'Track your orders within Dates',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SettingDetailBar(
                  icon: Icons.security,
                  text: 'Privacy policy',
                  subText: 'Track your orders within Dates',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SettingDetailBar(
                  icon: CupertinoIcons.rectangle_stack_fill_badge_person_crop,
                  text: 'Refernces',
                  subText: 'Track your orders within Dates',
                ),
                const SizedBox(
                  height: 10,
                ),
                const SettingDetailBar(
                  icon: Icons.wallet_rounded,
                  text: 'Wallet',
                  subText: 'Track your orders within Dates',
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      backgroundColor: TColors.white.withOpacity(1),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Upload Options',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ListTile(
                                leading: const Icon(
                                      Icons.blur_circular_rounded,
                                      color: TColors.darkGrey,
                                      size: 20,
                                    ),
                                title: const Text('Add Product'),
                                onTap: () {
                                  Get.to(()=>DeleteAndAddScreen());
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                      Icons.blur_circular_rounded,
                                      color: TColors.darkGrey,
                                      size: 20,
                                    ),
                                title: const Text('Update Product'),
                                onTap: () {
                                  Get.to(()=>UpdateProduct());
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                      Icons.blur_circular_rounded,
                                      color: TColors.darkGrey,
                                      size: 20,
                                    ),
                                title: const Text('Delete Product'),
                                onTap: () {
                                  Get.to(()=>DeleteAndAddScreen());
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const SettingDetailBar(
                    icon: Icons.upload_rounded,
                    text: 'Uploads',
                    subText: 'This is only available for Admins',
                  ),
                ),
                //Logout Button
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                          text: "Logout of your account?",
                          onCancelPressed: () {
                            Get.back(); // Close the dialog
                          },
                          onConfirmPressed: () {
                            controller
                                .logout(); // Handle confirm logic here, like deleting account
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: TColors.warning,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                      child: Text(
                        'Logout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            // fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: TColors.textWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
