import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_backend/model/models.dart' as model;

import 'dart:developer' as developer;

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<model.OrderStats>> getOrderStats() {
    return _firestore.collection('order_stats').orderBy('dateTime').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                model.OrderStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  Stream<List<model.Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => model.Product.fromSnapshot(doc))
          .toList();
    });
  }

  Stream<List<model.Order>> getOrders() {
    return _firestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => model.Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<model.Order>> getPendingOrders() {
    return _firestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => model.Order.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(model.Product product) {
    return _firestore
        .collection('products')
        .add(product.toMap())
        .then((value) => developer.log('Done: $value', name: 'Product'));
  }

  Future<void> addOrder(model.Order order) {
    return _firestore
        .collection('orders')
        .add(order.toMap())
        .then((value) => developer.log('Done: $value', name: 'Order'));
  }

  Future<void> updateProductField(
      model.Product product, String field, dynamic newValue) {
    return _firestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }

  Future<void> updateOrderField(
      model.Order order, String field, dynamic newValue) {
    return _firestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapshot) =>
            (querySnapshot.docs.first.reference.update({field: newValue})));
  }
}
