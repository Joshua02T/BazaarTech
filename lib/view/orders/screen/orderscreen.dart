import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/orders/controller/orderscontroller.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Orders'),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CustomProgressIndicator());
          }

          if (controller.orders.isEmpty) {
            return Center(
              child: Text(
                "No orders found",
                style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 25.75,
                    color: AppColors.black),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: MediaQueryUtil.screenHeight / 52.75),
            child: ListView.builder(
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                final order = controller.orders[index];
                return Card(
                  color: AppColors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      "Order #${order.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Status: ${order.status}\n"
                      "Date: ${order.orderDate}\n"
                      "Payment: ${order.paymentMethodCode}",
                    ),
                    trailing: Text(
                      "\$${order.totalPrice}",
                      style: const TextStyle(
                        color: AppColors.primaryOrangeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
