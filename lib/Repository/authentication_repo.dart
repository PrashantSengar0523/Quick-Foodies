import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_foodies/BottomNavBar/bottom_nav_bar.dart';
import 'package:quick_foodies/login&SignupScreen/login_screen.dart';
import 'package:quick_foodies/login&SignupScreen/verify_email.dart';
import 'package:quick_foodies/onbaordingScreen/onboarding_screen.dart';
import 'package:quick_foodies/utils/exceptions/firebase_exceptions.dart';
import 'package:quick_foodies/utils/exceptions/format_exceptions.dart';

import '../utils/exceptions/firebase_auth_exceptions.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();
  final auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;

  //variables
  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final user = auth.currentUser; // Use this to get the current user
    if(user != null) {
      if(user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  ///[Login]
  Future<void> loginWithEmail(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TFirebaseException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  ///[RegisterUser]
  Future<UserCredential> signupWithEmail(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Check if the user is signing up for the first time
      createLocalBucketForUser(); 

      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TFirebaseException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again.';
    }
  }

Future<void> createLocalBucketForUser() async {
    try {
      final box = GetStorage('user_bucket: ${currentUser?.uid}'); // Create a named bucket
      await box.write('initialized', true); // Mark bucket as initialized
      debugPrint('Local bucket created successfully for user: ${currentUser?.uid}');
    } catch (e) {
      debugPrint('Error creating local bucket: ${e.toString()}');
      // Handle storage errors gracefully (e.g., show a toast message)
    }
  }

  ///[Verification]
  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TFirebaseException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  ///[LogoutUser]
  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TFirebaseException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  ///[ForgotPassword]
  Future<void> resetPasswordWithEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const TFormatException();
    } on PlatformException catch(e) {
      throw TFirebaseException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Delete Authentication user
  Future<void> deleteAuthUser(User user) async {
    try {
      await user.delete();
      debugPrint("User deleted successfully from Authentication");
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
