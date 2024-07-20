import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/login&SignupScreen/login_screen.dart';
import 'package:quick_foodies/utils/popups/full_screen_loader.dart';

import '../../utils/popups/loaders.dart';

class ForgotPassController extends GetxController{
  static ForgotPassController get instance=>Get.find();

  //variables
  final email=TextEditingController();
  GlobalKey<FormState>forgotForm=GlobalKey<FormState>();

  forgotPassword()async{
    try{
      // start Loading
      TFullScreenLoader.openLoadingDialog("Logging you in...", 'assets/docer.json');

      //Form Validation
      if(!forgotForm.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;}

      await AuthenticationRepo.instance.resetPasswordWithEmail(email.text.trim());

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Email sent',message:"Email link sent to Reset your passwrod." );
      Get.offAll(()=>const LoginScreen());
    }
    catch(e){
      TFullScreenLoader.stopLoading();

      TLoaders.warningSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}