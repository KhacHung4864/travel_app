import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/banner_models.dart';
import 'package:travel_app/data/model/category_model.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class HomeController extends GetxController {
  HomeController();
  final HomeApi _homeApi = HomeApi();
  TextEditingController searchController = TextEditingController();
  RxList<Banners> listBanner = <Banners>[].obs;
  RxList<Categories> listCategory = <Categories>[].obs;
  RxList<Places> listPlaceByCategory = <Places>[].obs;
  RxList<Places> listPlace = <Places>[].obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData({isShowLoading = true}) async {
    if (isShowLoading) EasyLoading.show(status: 'Loading...');
    await Future.wait([
      getBanner(),
      getCategory(),
      getPlaces(categoryId: 6, listPlace: listPlaceByCategory),
      getPlaces(listPlace: listPlace),
    ]);
    if (isShowLoading) EasyLoading.dismiss();
  }

  Future<List<Banners>> getBanner() async {
    try {
      final response = await _homeApi.callBanner();
      BannerModel resData = BannerModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listBanner.value = [];
          resData.data?.banners?.forEach((record) {
            listBanner.add(record);
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
    }
    return listBanner;
  }

  Future<List<Categories>> getCategory() async {
    try {
      final response = await _homeApi.callCategory();
      CategoryModel resData = CategoryModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listCategory.value = [];
          resData.data?.categories?.forEach((record) {
            listCategory.add(record);
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
    }
    return listCategory;
  }

  Future<List<Places>?> getPlaces({int? categoryId, String? keyword, RxList<Places>? listPlace, bool isLoading = false}) async {
    try {
      final response = await _homeApi.callPlaces(categoryId: categoryId, keyword: keyword, isLoading: isLoading);
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
    }
    return listPlace;
  }
}
