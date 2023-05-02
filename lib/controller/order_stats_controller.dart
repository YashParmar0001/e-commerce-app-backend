import 'package:ecommerce_app_backend/model/models.dart';
import 'package:ecommerce_app_backend/services/database_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService databaseService = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = databaseService.getOrderStats();
    // for (OrderStats element in OrderStats.data) {
    //   databaseService.addOrderStats(element);
    // }
    super.onInit();
  }
}