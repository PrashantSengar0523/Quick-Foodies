import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/BottomNavBar/bottom_nav_bar.dart';
import 'package:quick_foodies/controllers/user_controller.dart';
import 'package:quick_foodies/utils/popups/full_screen_loader.dart';
import 'package:quick_foodies/Repository/user_repo.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  // Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  GlobalKey<FormState> updateForm = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserFields() async {
    try {
      TFullScreenLoader.openLoadingDialog("We are updating your information", 'assets/loader.json');

      if (!updateForm.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> updateUser={'FirstName':firstName.text.trim(),'LastName':lastName.text.trim()};
      await UserRepo.instance.updateUserrecord(updateUser);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "",message: "Your profile has been updated");
      Get.offAll(()=>const NavigationMenu());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!",message: e.toString());
    }
  }
}
