import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Models/user_model.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/Repository/user_repo.dart';
import 'package:quick_foodies/login&SignupScreen/verify_email.dart';
import 'package:quick_foodies/utils/popups/full_screen_loader.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';



class SignupController extends GetxController{
  static SignupController get instance=>Get.find();

  //variables
  final hidePassword=true.obs;
  final firstName=TextEditingController();
  final lastName=TextEditingController();
  final email=TextEditingController();
  final password=TextEditingController();
  final phone=TextEditingController();
  GlobalKey<FormState> signupForm=GlobalKey<FormState>();

  /// ---Signup
  Future<void> signup()async{
    try{
      
      // start Loading
      TFullScreenLoader.openLoadingDialog("We are processing your infomation...", 'assets/docer.json');

      //Form Validation
      if(!signupForm.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;}

      //Register User in the Firebase Authentication
      final userCredential=await AuthenticationRepo.instance.signupWithEmail(email.text.trim(), password.text.trim());

      //save userData in Firebase Firestore
      final user=UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phone: phone.text.trim(),
        profile: 'https://i.postimg.cc/7LBygY8x/user.png');

      final userRepository=Get.put(UserRepo());
      await userRepository.saveUserRecord(user);

      //Remove Loader
      TFullScreenLoader.stopLoading();
        
      //Success message
      TLoaders.successSnackBar(title: 'Congratulation',message: "Your account has been created! Verify your email");

      //Move to Verify Email Screen
      Get.to(()=>VerifyEmailScreen(email: email.text.trim(),));

      // UserController.instance.user(user); // Add this line to update the user in the UserController
    }
    catch(e){
      TFullScreenLoader.stopLoading();

      TLoaders.warningSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
  
}