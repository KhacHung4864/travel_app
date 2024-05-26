import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';

class ForgotController extends GetxController {
  final UserApi _userApi = UserApi();

  final emailController = TextEditingController();

  Future<bool> forgotPassword({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.forgotPassword(data: data);
      UserModel resData = UserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          return true;
        } else {
          showError(resData.message);
          return false;
        }
      } else {
        showError(resData.message);
        return false;
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }
}

 //FIREBASE
