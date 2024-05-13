import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';

class SignUpController extends GetxController {
  final UserApi _userApi = UserApi();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || nameController.text.trim().isEmpty && emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty) {
      return;
    }
    signUpUser(
      data: {
        "username": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      },
    );
  }

  void signUpUser({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.callsignUpUser(data: data);
      UserModel resData = UserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          Get.back();
          showDialogSuccess('Sign Up Success');
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
