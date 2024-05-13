import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/data/network/api/user_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/favorites/favorites_screen.dart';
import 'package:travel_app/modules/fragments/home/home_screen.dart';
import 'package:travel_app/modules/fragments/order/order_screen.dart';
import 'package:travel_app/modules/fragments/profile/profile_screen.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class DashboardFragmentsController extends GetxController {
  DashboardFragmentsController();
  final UserApi _userApi = UserApi();

  final Rx<User?> currentUser = User().obs;
  Rx<int> currentIndexs = 0.obs;
  Rx<int> backButtonPressCount = 0.obs;

  List<Widget> fragmentScreen = [
    const HomeScreen(),
    const FavoritesScreen(),
    const OrderScreen(),
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
      'active_icon': Icons.favorite,
      'non_active_icon': Icons.map,
      'label': 'Maps',
    },
    {
      'active_icon': Icons.message_outlined,
      'non_active_icon': Icons.message_outlined,
      'label': 'Message',
    },
    {
      'active_icon': Icons.person,
      'non_active_icon': Icons.person_outline,
      'label': 'Profile',
    }
  ];

  @override
  void onInit() {
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
