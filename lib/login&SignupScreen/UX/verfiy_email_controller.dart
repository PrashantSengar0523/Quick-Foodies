import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/utils/constants/text_strings.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';
import 'package:quick_foodies/widgets/success_screen.dart';

class VerfiyEmailController extends GetxController {
  static VerfiyEmailController get instance => Get.find();

  @override
  onInit() {
    verifyEmail();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //verifyEmail
  verifyEmail() async {
    try {
      AuthenticationRepo.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: "Please check your inbox to verify email.");
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => SuccessScreeen(
            image: '',
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: AuthenticationRepo.instance.screenRedirect));
      }
    });
  }

  checkEmailVerificationStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.offAll(() => SuccessScreeen(
            image: '',
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: AuthenticationRepo.instance.screenRedirect));
    }
  }
}
