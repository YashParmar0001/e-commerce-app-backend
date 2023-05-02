import 'package:ecommerce_app_backend/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/models.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  OrderCard({Key? key, required this.order}) : super(key: key);

  final Order order;
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    var products = Product.products
        .where((product) => order.productIds.contains(int.parse(product.id!)))
        .toSet()
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.grey,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order id: ${order.id}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(order.createdAt),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Image.network(
                          products[index].imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                products[index].description,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Delivery Fee',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${order.deliveryFee}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${order.total}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (order.isAccepted)
                      ? ElevatedButton(
                          onPressed: () {
                            orderController.updateOrderDelivery(order, true);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: const Text('Deliver'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            orderController.updateOrderAcceptance(order, true);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: const Text('Accept'),
                        ),
                  ElevatedButton(
                    onPressed: () {
                      orderController.updateOrderAcceptance(order, false);
                      orderController.updateOrderDelivery(order, false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
