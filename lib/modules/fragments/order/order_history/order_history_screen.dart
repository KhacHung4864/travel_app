import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/data/model/order_model.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/order/order_controller.dart';
import 'package:travel_app/routes/app_pages.dart';

class OrderHistoryScreen extends GetView<OrderController> {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Order image       //history image
          //myOrder title     //history title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //order icon image
                // my orders

                //history icon image
                // history
                GestureDetector(
                  onTap: () {
                    //send user to orders history screen
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Assets.images.historyIcon.image(width: 140.w),
                        const SizedBox(height: 10),
                        const Text(
                          "My History",
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //some info
          Obx(
            () => controller.isLoading.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      controller.orderHistoryList.isEmpty ? "No order item found" : "Here are your successfully received parcels.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
          ),

          //displaying the user orderList
          Expanded(
            child: Obx(() => displayOrdersList(context)),
          ),
        ],
      ),
    );
  }

  Widget displayOrdersList(context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getHistorytUserorderList();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
        itemCount: controller.orderHistoryList.length,
        itemBuilder: (context, index) {
          OrderData eachOrderData = controller.orderHistoryList[index];

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
