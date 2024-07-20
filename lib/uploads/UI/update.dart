import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';
import 'package:quick_foodies/utils/validators/validation.dart';

import '../../controllers/update_product_controller.dart';

class UpdateProduct extends StatelessWidget {
  final controller = Get.put(UpdateProductController());
  UpdateProduct({super.key});

  // final ValueNotifier<Uint8List?> _selectedImageBytes =
  //     ValueNotifier<Uint8List?>(null);

  // void _selectImage(BuildContext context) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     _selectedImageBytes.value = result.files.single.bytes;
  //     controller.image.text = result.files.single.name;
  //   } else {
  //     // User canceled the picker
  //   }
  // }


  void handleupdateProduct() {
    if (controller.id.text.trim().isEmpty) {
      // Show a user-friendly popup indicating missing productId
      TLoaders.errorSnackBar(
          title: '',
          message:
              'Product Id is required.');
      return;
    }
    
    controller.updateProductFields(controller.id.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: const Text(
          'Update',
          style: TextStyle(color: TColors.darkerGrey),
        ),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: TColors.darkerGrey,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.updateForm,
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: controller.id,
                validator: (value) =>
                    TValidator.validateId(value),
                decoration: const InputDecoration(
                  labelText: 'ID',
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
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.productName,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
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
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.price,
                      decoration: const InputDecoration(
                        labelText: 'Price',
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
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.calories,
                      decoration: const InputDecoration(
                        labelText: 'Calories',
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
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.rating,
                      decoration: const InputDecoration(
                        labelText: 'Rating',
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
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.description,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
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
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(TColors.warning),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        side: WidgetStateProperty.all<BorderSide>(
                            BorderSide.none),
                        shape:
                            WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(11)))),
                    onPressed: () {
                      handleupdateProduct();
                    },
                    child: const Text('Update'),
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
