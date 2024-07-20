import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_foodies/login&SignupScreen/login_screen.dart';

class OnboardingScreenController extends GetxController {
  static OnboardingScreenController get instance=>Get.find();
  
  final storage=GetStorage();

  void navigateToLoginScreen() {
    storage.write('isFirstTime', false);
    Get.to(() => const LoginScreen());
  }
}
