import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/data/model/order_model.dart';
import 'package:travel_app/data/network/api/cart_api/cart_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/cart/cart_controller.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:vietmap_flutter_plugin/vietmap_flutter_plugin.dart';

class OrderController extends GetxController {
  final CartApi cartApi = CartApi();
  final CartController cartController = Get.find();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  RxList<OrderData> orderList = <OrderData>[].obs;
  RxList<OrderData> orderHistoryList = <OrderData>[].obs;

  RxBool isLoading = false.obs;

  //Map
  Rx<VietmapController?> mapController = Rx<VietmapController?>(null);
  final List<Marker> nearbyMarker = [];

  @override
  void onInit() async {
    // getCurrentUserorderList();
    // getHistorytUserorderList(isShowLoading: false);
    Vietmap.getInstance("506862bb03a3d71632bdeb7674a3625328cb7e5a9b011841");
    super.onInit();
  }

  Future<void> checkMap() async {
    var res = await Vietmap.reverse(const LatLng(21.027763, 105.834160));

    Vietmap.autocomplete(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.geoCode(VietMapAutoCompleteParams(textSearch: 'Hà Nội'));
    Vietmap.reverse(const LatLng(21.027763, 105.834160));
    Vietmap.place('Place ID');
    var routingResponse = await Vietmap.routing(VietMapRoutingParams(points: [const LatLng(10.779391, 106.624833), const LatLng(10.741039, 106.672116)]));
    routingResponse.fold((Failure failure) {
      // handle failure here
    }, (VietMapRoutingModel success) {
      if (success.paths?.isNotEmpty == true && success.paths![0].points?.isNotEmpty == true) {}
    });
    Vietmap.getVietmapStyleUrl();
  }

  Future<void> getCurrentUserorderList({bool isShowLoading = true}) async {
    isLoading.value = true;
    orderList.value = [];
    int currentUserId = dashboardFragmentsController.currentUser.value!.id!;
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await cartApi.callOrderList(
        data: {'user_id': currentUserId, 'token': token},
        isShowLoading: isShowLoading,
      );
      OrderModel resData = OrderModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          resData.data?.forEach((record) {
            orderList.add(record);
          });
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

  Future<void> getHistorytUserorderList({bool isShowLoading = true}) async {
    isLoading.value = true;
    orderHistoryList.value = [];
    int currentUserId = dashboardFragmentsController.currentUser.value!.id!;
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await cartApi.callOrderHistoryList(
        data: {'user_id': currentUserId, 'token': token},
        isShowLoading: isShowLoading,
      );
      OrderModel resData = OrderModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          resData.data?.forEach((record) {
            orderHistoryList.add(record);
          });
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
