import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../model/product_model.dart';

import 'dart:developer' as developer;

class ProductCard extends StatelessWidget {
  ProductCard({Key? key, required this.product, required this.index})
      : super(key: key);

  final Product product;
  final int index;
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    developer.log('Creating product card: ${product.toMap()}', name: 'Product');
    return Card(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 35,
                            child: Text(
                              'Price',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Slider(
                            value: product.price.toDouble(),
                            divisions: 10,
                            min: 0,
                            max: 100,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductPrice(
                                  index, product, value);
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductPrice(
                                  product, value);
                            },
                          ),
                          Text('\$${product.price}')
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(
                            width: 35,
                            child: Text(
                              'Qty.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Slider(
                            value: product.quantity.toDouble(),
                            divisions: 10,
                            min: 0,
                            max: 100,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black12,
                            onChanged: (value) {
                              productController.updateProductQuantity(
                                  index, product, value.toInt());
                            },
                            onChangeEnd: (value) {
                              productController.saveNewProductQuantity(
                                  product, value.toInt());
                            },
                          ),
                          Text('${product.quantity}')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
