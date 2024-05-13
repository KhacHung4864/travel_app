import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/order_model.dart';
import 'package:travel_app/data/network/api/cart_api/cart_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/cart/cart_controller.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class OrderDetailController extends GetxController {
  final CartApi cartApi = CartApi();
  final CartController cartController = Get.find();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final OrderData orderItem = Get.arguments[0];
  final bool isAdmin = Get.arguments[1];
  RxBool isLoading = false.obs;

  Future<void> updateStatusValueInDatabase({bool isShowLoading = true}) async {
    isLoading.value = true;

    try {
      final response = await cartApi.updateStatusItem(
        data: {'order_id': orderItem.orderId},
        isShowLoading: isShowLoading,
      );
      OrderModel resData = OrderModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          orderItem.status?.value = 1;
        } else {
          showError(resData.message);
        }
      } else {
        showError(resData.message);
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    } finally {
      isLoading.value = false;
    }
  }
}
