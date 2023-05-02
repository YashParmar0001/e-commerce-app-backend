import 'package:ecommerce_app_backend/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/add_something_card.dart';

import 'dart:developer' as developer;

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Smoothies',
      'Soft Drinks',
      'Water',
      'Fashion',
      'Food'
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a product'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: AddSomethingCard(
                        title: 'Add an image',
                        onTap: () async {
                          ImagePicker _picker = ImagePicker();
                          final XFile? _image = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (_image == null) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected!')));
                            Get.snackbar('', 'No image selected!',
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            developer.log('Uploading image: ${_image.name}',
                                name: 'Product');
                            productController.uploadImage(_image);
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Product Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  _buildTextFormField('Product ID', 'id', productController),
                  _buildTextFormField(
                      'Product Name', 'name', productController),
                  _buildTextFormField(
                      'Product Description', 'description', productController),
                  DropdownButtonFormField(
                      iconSize: 30,
                      decoration: InputDecoration(hintText: 'Product Category'),
                      items: categories.map((category) {
                        return DropdownMenuItem(value: category, child: Text(category));
                      }).toList(),
                      onChanged: (value) {
                        productController.newProduct.update(
                            'category', (_) => value,
                            ifAbsent: () => value);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildSlider('Price', 'price', productController,
                      productController.price),
                  _buildSlider('Qty.', 'quantity', productController,
                      productController.quantity),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildCheckbox('Recommended', 'isRecommended',
                      productController, productController.isRecommended),
                  _buildCheckbox('Popular', 'isPopular', productController,
                      productController.isPopular),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            developer.log(
                                'New product: ${productController.newProduct}',
                                name: 'Product');
                            productController.addNewProduct();
                          },
                          child: const Text('Save'))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String hintText, String name, ProductController productController) {
    return TextFormField(
      onChanged: (value) {
        productController.newProduct
            .update(name, (_) => value, ifAbsent: () => value);
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  Widget _buildSlider(String title, String name,
      ProductController productController, double? controllerValue) {
    return Row(
      children: [
        SizedBox(width: 35, child: Text(title)),
        Expanded(
          child: Slider(
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 100,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            divisions: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String title, String name,
      ProductController productController, bool? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(title),
        ),
        Checkbox(
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: () => value);
          },
          value: (controllerValue == null) ? false : controllerValue,
          activeColor: Colors.black12,
          checkColor: Colors.black,
        )
      ],
    );
  }
}
