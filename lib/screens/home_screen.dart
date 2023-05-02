import 'package:ecommerce_app_backend/controller/order_stats_controller.dart';
import 'package:ecommerce_app_backend/model/models.dart';
import 'package:ecommerce_app_backend/widgets/custom_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app_backend/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My eCommerce'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            FutureBuilder(
              future: orderStatsController.stats.value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 300,
                    child: CustomBarChart(
                      orderStats: snapshot.data!,
                    ),
                  );
                }else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }else {
                  return const CircularProgressIndicator(color: Colors.black,);
                }
              },
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to products'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  Get.to(() => OrdersScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text('Go to orders'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
