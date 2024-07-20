import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';

import '../../utils/popups/full_screen_loader.dart';
import '../../utils/popups/loaders.dart';

class LoginController extends GetxController{
  static LoginController get instance=>Get.find();

  //variables
  final hidePasswords=true.obs;
  final email=TextEditingController();
  final password=TextEditingController();
  GlobalKey<FormState> loginForm=GlobalKey<FormState>();

  Future<void> emailPasswordSignIn()async{
    try{
      
      // start Loading
      TFullScreenLoader.openLoadingDialog("Logging you in...", 'assets/docer.json');

      //Form Validation
      if(!loginForm.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;}
      
      //Logging User
      await AuthenticationRepo.instance.loginWithEmail(email.text.trim(), password.text.trim());

      //Redirect to Screen
      AuthenticationRepo.instance.screenRedirect();
      TLoaders.successSnackBar(title: 'Logged in');

    }
    catch(e){
      TFullScreenLoader.stopLoading();

      TLoaders.warningSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}