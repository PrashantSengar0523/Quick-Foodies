import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_foodies/MyApp/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quick_foodies/Repository/authentication_repo.dart';
import 'package:quick_foodies/Repository/user_repo.dart';
import 'firebase_options.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();   

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value)=>{
      Get.put(AuthenticationRepo()),
      Get.put(UserRepo())
  });
  runApp(const MyApp());
}