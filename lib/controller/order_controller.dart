import 'package:ecommerce_app_backend/services/database_service.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';

class OrderController extends GetxController {
  final DatabaseService databaseService = Get.put(DatabaseService());

  var orders = <Order>[].obs;
  var pendingOrders = <Order>[].obs;

  @override
  void onInit() {
    orders.bindStream(databaseService.getOrders());
    pendingOrders.bindStream(databaseService.getPendingOrders());
    super.onInit();
  }

  void updateOrderAcceptance(Order order, bool value) {
    databaseService.updateOrderField(order, 'isAccepted', value);
    if (!value) {
      databaseService.updateOrderField(order, 'isCancelled', true);
    }else {
      databaseService.updateOrderField(order, 'isCancelled', false);
    }
  }

  void updateOrderDelivery(Order order, bool value) {
    databaseService.updateOrderField(order, 'isDelivered', value);
  }
}