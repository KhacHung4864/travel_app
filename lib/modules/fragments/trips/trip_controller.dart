import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/list_trip_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

import '../../../data/network/service/api_exception.dart';

class TripController extends GetxController {
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final HomeApi _homeApi = HomeApi();
  TripController();

  RxList<Trips> listTrips = <Trips>[].obs;

  Trips selectedTrip = Trips();
  bool isEdit = false;
  @override
  void onInit() {
    getListTrips();
    super.onInit();
  }

  Future<void> getListTrips({bool isShowloading = true}) async {
    try {
      if (isShowloading) EasyLoading.show(status: 'Loading...');
      final response = await _homeApi.callListTrip(
        id: dashboardFragmentsController.currentUser.value?.id,
        longitude: dashboardFragmentsController.position?.longitude,
        latitude: dashboardFragmentsController.position?.latitude,
      );
      ListTripModel resData = ListTripModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listTrips.value = [];
          resData.data?.trips?.forEach((record) {
            listTrips.add(record);
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
      if (isShowloading) EasyLoading.dismiss();
    }
  }

  Future<void> removeTrip({int? tripID, bool isShowloading = true}) async {
    try {
      if (isShowloading) EasyLoading.show(status: 'Loading...');
      final response = await _homeApi.callDeleteTrip(tripId: tripID);
      ListTripModel resData = ListTripModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          Fluttertoast.showToast(msg: resData.message ?? '');
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
      if (isShowloading) EasyLoading.dismiss();
    }
  }
}
