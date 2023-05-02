import 'package:ecommerce_app_backend/controller/controller.dart';
import 'package:ecommerce_app_backend/model/order_model.dart';
import 'package:ecommerce_app_backend/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: orderController.pendingOrders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: orderController.pendingOrders[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
