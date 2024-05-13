import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/data/model/order_model.dart';
import 'package:travel_app/modules/fragments/order/order_controller.dart';
import 'package:travel_app/routes/app_pages.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget displayOrdersList(context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getCurrentUserorderList();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
        itemCount: controller.orderList.length,
        itemBuilder: (context, index) {
          OrderData eachOrderData = controller.orderList[index];

          return Card(
            color: Colors.white24,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: ListTile(
                onTap: () {
                  Get.toNamed(Routes.orderDetail, arguments: [eachOrderData, false]);
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID # ${eachOrderData.orderId}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Amount: \$ ${eachOrderData.totalAmount}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //date
                    //time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //date
                        Text(
                          DateFormat("dd MMMM, yyyy").format(eachOrderData.dateTime!),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        //time
                        Text(
                          DateFormat("hh:mm a").format(eachOrderData.dateTime!),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 6),

                    const Icon(
                      Icons.navigate_next,
                      color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
