import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/login&SignupScreen/UX/forgot_pass_controller.dart';
import 'package:quick_foodies/utils/validators/validation.dart';



class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ForgotPassController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.remove_circle_outline_rounded)), // This line can also be removed as true is the default value
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            ),
            const SizedBox(height: 2),
            const Text(
              "Don't worry sometimes people can forget the password too, enter your email we will send a password reset link.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 40,),
            Form(
              key: controller.forgotForm,
              child: TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black54,
                  ),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: OutlinedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.deepOrange),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    side: WidgetStateProperty.all<BorderSide>(BorderSide.none),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  controller.forgotPassword();
                },
                child: const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
