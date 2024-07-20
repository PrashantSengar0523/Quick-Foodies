import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        
        useMaterial3: false,

      ),
      home: const Scaffold(backgroundColor: TColors.warning, body: Center(child: CircularProgressIndicator(),),),
    );
  }
}