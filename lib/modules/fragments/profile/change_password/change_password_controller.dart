import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/data/network/api/user_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class ChangePassController extends GetxController {
  final UserApi _userApi = UserApi();

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  Future changePassword({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.changePassword(data: data);
      UserModel resData = UserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          Get.back();
          showDialogSuccess(resData.message);
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

 //FIREBASE
