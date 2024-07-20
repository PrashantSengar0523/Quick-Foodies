import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/Models/user_model.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/Repository/user_repo.dart';
import 'package:quick_foodies/login&SignupScreen/signup_screen.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';

import '../utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.put(UserController());
  final userRepo=UserRepo.instance;
  final authRepo=AuthenticationRepo.instance;
  // Variables to store user data
  Rx<UserModel> user = UserModel(id: '', email: '', firstName: '', lastName: '', phone: '').obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord(); // Fetch user record on controller initialization
  }
  
  // Function to fetch user record
  Future<void> fetchUserRecord() async {
    try {
      UserModel userRecord = await UserRepo.instance.getUserRecord();
      user(userRecord);
      debugPrint('User record fetched: ${userRecord.toJson()}'); // Debug statement
    } catch (e) {
      debugPrint('Error fetching user record: $e');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.transparent,
          colorText: Colors.white);
    }
  }
  
  // Function to save user record
  Future<void> saveUserRecord(UserModel userRecord) async {
    try {
      await UserRepo.instance.saveUserRecord(userRecord);
      user(userRecord); // Update the local user data with the new record
      debugPrint('User record saved: ${userRecord.toJson()}'); // Debug statement
      Get.snackbar('Success', 'User record saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.transparent,
          colorText: Colors.white);
    } catch (e) {
      debugPrint('Error saving user record: $e');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.transparent,
          colorText: Colors.white);
    }
  }

  Future<void> deleteUser() async {
    try {
      TFullScreenLoader.openLoadingDialog("Deleting user", 'assets/loader.json');

      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        TFullScreenLoader.stopLoading();
        Get.snackbar('Error', 'No authenticated user found');
        return;
      }

      // Delete Firestore user record
      await userRepo.delelteUser(currentUser.uid);

      // Delete Authentication user
      await authRepo.deleteAuthUser(currentUser);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: "User Account has been deleted");
      Get.off(()=>const SignupScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error",message: e.toString());
    }
  }

}
