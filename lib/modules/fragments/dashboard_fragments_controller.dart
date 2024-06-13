import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/data/network/api/user_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/home/home_screen.dart';
import 'package:travel_app/modules/fragments/profile/profile_screen.dart';
import 'package:travel_app/modules/fragments/search_place/search_item_screen.dart';
import 'package:travel_app/modules/fragments/trips/trip_screen.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class DashboardFragmentsController extends GetxController {
  DashboardFragmentsController();
  final UserApi _userApi = UserApi();

  final Rx<User?> currentUser = User().obs;
  Rx<int> currentIndexs = 0.obs;
  Rx<int> backButtonPressCount = 0.obs;
  Position? position;

  List<Widget> fragmentScreen = [
    const HomeScreen(),
    const SearchScreen(),
    TripScreen(),
    const ProfileScreen(),
  ];
  var tabNames = ['Home', 'Maps', 'Message', 'Profile'].obs;
  List navigationButton = [
    {
      'active_icon': Icons.home,
      'non_active_icon': Icons.home_outlined,
      'label': 'Home',
    },
    {
      'active_icon': Icons.search,
      'non_active_icon': Icons.search_outlined,
      'label': 'Search',
    },
    {
      'active_icon': Icons.card_travel_rounded,
      'non_active_icon': Icons.card_travel_sharp,
      'label': 'Trip',
    },
    {
      'active_icon': Icons.person,
      'non_active_icon': Icons.person_outline,
      'label': 'Profile',
    }
  ];

  @override
  void onInit() {
    getCurrentLocation();
    getUserData();
    super.onInit();
  }

  tabBottomBar() {
    // if (currentIndexs.value == 0) {
    //   if (Get.isRegistered<HomeController>() == false) {
    //     Get.lazyPut<HomeController>(() => HomeController());

    //   }
    // }
    // if (currentIndexs.value == 3) {
    //   if (Get.isRegistered<ProfileController>() == false) {
    //     Get.lazyPut<ProfileController>(() => ProfileController());
    //   }
    // }
  }

  getCurrentLocation() async {
    position = await checkPermisson();
  }

  Future<Position> checkPermisson() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getUserData() async {
    String? token = AppStorage().getString(SKeys.tokenUser);
    if (token != null && token.isNotEmpty) {
      try {
        final response = await _userApi.callUserData(token: token);
        UserModel resData = UserModel.fromJson(response.data);
        if (response.statusCode == 200) {
          if (resData.code == 0) {
            AppStorage().setString(SKeys.currentUser, jsonEncode(resData.data?.toJson()));
            currentUser.value = resData.data?.user;
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
    }
  }
}
