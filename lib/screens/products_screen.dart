import 'package:ecommerce_app_backend/controller/controller.dart';
import 'package:ecommerce_app_backend/model/models.dart';
import 'package:ecommerce_app_backend/screens/screens.dart';
import 'package:ecommerce_app_backend/widgets/add_something_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddSomethingCard(
                title: 'Add a product',
                onTap: () {
                  Get.to(() => NewProductScreen());
                }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Obx(
                () => ListView.builder(
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => ProductCard(
                          product: productController.products[index],
                          index: index,
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
