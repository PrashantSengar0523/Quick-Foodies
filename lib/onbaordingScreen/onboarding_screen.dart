import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/common/widgets/shimmers/shimmer.dart';
import 'package:quick_foodies/onbaordingScreen/UX/onboarding_controller.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OnboardingScreenController());
    return Scaffold(
      backgroundColor: TColors.warning,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            CachedNetworkImage(
              imageUrl: 'https://i.postimg.cc/bwHxykJ0/fourth.png',
              width: 300,
              height: 260,
              placeholder: (context, url) => const TShimmerEffect(width: 100, height: 100),
              errorWidget: (context, url, error) => const Text("loading...")
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "     Quick Foodies \n Delight in Every Bite",
                style: TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Home delivery and online reservation \n system for restaurants & cafe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.textWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                   onPressed: ()=>controller.navigateToLoginScreen(),
                  child: const Text(
                    "Let's Explore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: TColors.warning,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




