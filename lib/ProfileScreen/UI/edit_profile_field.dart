import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_foodies/controllers/update_name_controler.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';
import 'package:quick_foodies/utils/validators/validation.dart';

class EditProfilefilds extends StatelessWidget {
  const EditProfilefilds({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(UpdateNameController());
    return Scaffold(
      backgroundColor: TColors.lightGrey,
      appBar: AppBar(
        title: const Text(
                    'Change Name',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.black87),
                  ),
                  elevation: 0,
                  backgroundColor: TColors.lightGrey,
                  automaticallyImplyLeading: true,
                  leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded,color:Colors.black54,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.updateForm,
          child: Column(
            children: [
              const Text("Use real name for easy verification. This name will apper on several screens.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
              const SizedBox(height: 24,),
              TextFormField(
                obscureText: false,
                controller: controller.firstName,
                validator: (value) => TValidator.validateEmptyText('First Name', value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.forward,
                    color: Colors.black54,
                  ),
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: TColors.darkGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: TColors.darkGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: TColors.darkGrey),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              TextFormField(
                controller: controller.lastName,
                validator: (value) => TValidator.validateEmptyText('Last Name', value),
                obscureText: false,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Iconsax.forward,
                    color: Colors.black54,
                  ),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: TColors.darkGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: TColors.darkGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: TColors.darkGrey),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              GestureDetector(
                  onTap: controller.updateUserFields,
                  child: Container(
                    height: 40,
                    width: 400,
                    decoration: BoxDecoration(
                      color: TColors.warning,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            // fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: TColors.textWhite),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}