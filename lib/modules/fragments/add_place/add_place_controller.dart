import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/places/place_trip_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/modules/fragments/trips/create_trip/create_trip_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class AddPlaceController extends GetxController {
  final HomeApi _homeApi = HomeApi();
  AddPlaceController();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  final CreateTripController createTripController = Get.find();

  TextEditingController searchController = TextEditingController();
  final RxBool isLoading = false.obs;
  RxList<PlaceTrip> listPlaceTrip = <PlaceTrip>[].obs;

  @override
  void onInit() {
    searchPlaces(keyword: searchController.text, loading: true);
    super.onInit();
  }

  Future<void> searchPlaces({String? keyword, bool loading = true}) async {
    try {
      isLoading.value = true;
      final response =
          await _homeApi.callPlaceTrip(keyword: keyword, isLoading: loading, longitude: dashboardFragmentsController.position!.longitude, latitude: dashboardFragmentsController.position!.latitude);
      PlaceTripModel resData = PlaceTripModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listPlaceTrip.value = [];
          resData.data?.places?.forEach((record) {
            listPlaceTrip.add(record);
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
