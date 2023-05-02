import 'package:ecommerce_app_backend/services/database_service.dart';
import 'package:ecommerce_app_backend/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:developer' as developer;

import '../model/models.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  // var products = Product.products.obs;
  StorageService storageService = Get.put(StorageService());
  DatabaseService databaseService = Get.put(DatabaseService());

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  @override
  void onInit() {
    products.bindStream(databaseService.getProducts());
    super.onInit();
  }

  void addNewProduct() {
    databaseService.addProduct(Product.fromMap(newProduct));
  }

  void updateProductPrice(int index, Product product, double value) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(Product product, double newValue) {
    databaseService.updateProductField(product, 'price', newValue);
  }

  void saveNewProductQuantity(Product product, int newValue) {
    databaseService.updateProductField(product, 'quantity', newValue);
  }

  void updateProductQuantity(int index, Product product, int value) {
    product.quantity = value;
    products[index] = product;
  }

  void uploadImage(XFile image) async {
    await storageService.uploadImage(image);
    var imageUrl = await storageService.getDownloadUrl(image.name);
    newProduct.update('imageUrl', (_) => imageUrl, ifAbsent: () => imageUrl);
    developer.log('Image uploaded successfully: $imageUrl', name: 'Product');
  }
}