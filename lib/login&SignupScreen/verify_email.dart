import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/login&SignupScreen/UX/verfiy_email_controller.dart';
// Import any other necessary packages here
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerfiyEmailController());
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        // Uncomment and add action if needed
        actions: [
          IconButton(
              onPressed: () {
                AuthenticationRepo.instance.logout();
              },
              icon: const Icon(
                CupertinoIcons.clear,
                color: TColors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: TSizes.defaultSpace,
              right: TSizes.defaultSpace,
              bottom: TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                email ?? 'codewizard0523@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Text(
                TTexts.confirmEmailSubTitle,
                style: TextStyle(color: TColors.darkGrey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(TColors.warning),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.checkEmailVerificationStatus();
                  },
                  child: const Text(
                    TTexts.tContinue,
                    style: TextStyle(color: TColors.textWhite),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      controller.verifyEmail();
                    },
                    child: const Text(
                      TTexts.resendEmail,
                      style: TextStyle(color: TColors.warning),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
