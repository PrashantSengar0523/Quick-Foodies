import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quick_foodies/controllers/product_controller.dart';
import 'package:quick_foodies/utils/constants/colors.dart';
import 'package:quick_foodies/utils/popups/loaders.dart';
import 'package:quick_foodies/utils/validators/validation.dart';

class DeleteAndAddScreen extends StatelessWidget {
  final controller = Get.put(ProductController());
  DeleteAndAddScreen({super.key});

  final ValueNotifier<Uint8List?> _selectedImageBytes =
      ValueNotifier<Uint8List?>(null);

  void _selectImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      _selectedImageBytes.value = result.files.single.bytes;
      controller.image.text = result.files.single.name;
    } else {
      // User canceled the picker
    }
  }

  void handleAddProduct() {
    if (controller.productName.text.trim().isEmpty &&
        controller.price.text.trim().isEmpty &&
        controller.calories.text.trim().isEmpty &&
        controller.rating.text.trim().isEmpty &&
        controller.description.text.trim().isEmpty &&
        controller.category.text.trim().isEmpty) {
      // Show a user-friendly popup indicating missing productId
      TLoaders.errorSnackBar(
          title: '', message: 'Fields are required. Please fill them');
      return;
    }
    if(controller.id.text.trim().isNotEmpty){
         TLoaders.errorSnackBar(
          title: '', message: 'Id is not required. It will generate automatically.');
      return;
    }
    if (_selectedImageBytes.value == null) {
      TLoaders.errorSnackBar(title: '', message: 'Please select the image.');
      return;
    }
    controller.createProduct(_selectedImageBytes.value!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        backgroundColor: TColors.white,
        title: const Text(
          'Add',
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
          key: controller.addForm,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => _selectImage(context),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: ValueListenableBuilder<Uint8List?>(
                    valueListenable: _selectedImageBytes,
                    builder: (context, value, child) {
                      if (value != null) {
                        return ClipOval(
                          child: Image.memory(
                            value,
                            height: 150,
                            width: 150,
                            fit: BoxFit.contain,
                          ),
                        );
                      } else {
                        return const Center(
                          child: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.grey,
                            size: 50,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: controller.id,
                // validator: (value) => TValidator.validateId(value),
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
                validator: (value) =>
                    TValidator.validateEmptyText('Product Name', value),
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
                      validator: (value) =>
                          TValidator.validateEmptyText('Price', value),
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
                      validator: (value) =>
                          TValidator.validateEmptyText('Calories', value),
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
                      validator: (value) =>
                          TValidator.validateEmptyText('Rating', value),
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
                validator: (value) =>
                    TValidator.validateEmptyText('Description', value),
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
              const SizedBox(height: 16),
              TextFormField(
                      controller: controller.category,
                      validator: (value) =>
                          TValidator.validateEmptyText('category', value),
                      decoration: const InputDecoration(
                        labelText: 'Category For eg. Desert',
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
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: double.minPositive,
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
                          handleAddProduct();
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: double.minPositive,
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
                          if (controller.id.text.trim().isEmpty) {
                            TLoaders.errorSnackBar(
                                title: '', message: 'Product Id must be provided');
                            return;
                          }
                          controller.deleteProduct(controller.id.text.trim());
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
