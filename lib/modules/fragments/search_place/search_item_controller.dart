import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class SearchItemController extends GetxController {
  final HomeApi _homeApi = HomeApi();
  SearchItemController();

  TextEditingController searchController = TextEditingController();
  final RxBool isLoading = false.obs;
  RxList<Places> listPlaceSearch = <Places>[].obs;
  @override
  void onInit() {
    searchPlaces(keyword: searchController.text, listPlace: listPlaceSearch, loading: false);
    super.onInit();
  }

  Future<void> searchPlaces({String? keyword, RxList<Places>? listPlace, bool loading = true}) async {
    try {
      isLoading.value = true;
      final response = await _homeApi.callPlaces(keyword: keyword, isLoading: loading);
      PlaceModel resData = PlaceModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listPlace?.value = [];
          resData.data?.places?.forEach((record) {
            listPlace?.add(record);
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
