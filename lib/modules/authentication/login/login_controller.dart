import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/data/model/user_model.dart';
import 'package:travel_app/routes/app_pages.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';

class LoginController extends GetxController {
  final UserApi _userApi = UserApi();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // firebase
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  firebase.User? _user;

  @override
  void onInit() {
    _auth.authStateChanges().listen((event) {
      _user = event;
    });
    super.onInit();
  }

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }

  void loginWithGoggle() async {
    try {
      final response = await _userApi.callLoginWithGoogle();
      if (response.statusCode == 0) {}
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }

  void loginUser({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.callLoginUser(data: data);
      UserModel resData = UserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          AppStorage().setString(SKeys.tokenUser, resData.data?.accessToken ?? '');
          AppStorage().setString(SKeys.currentUser, jsonEncode(resData.data?.user?.toJson()));
          Get.toNamed(Routes.dashBoardFragment);
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

  void handleGoogleSignIn() async {
    try {
      firebase.GoogleAuthProvider googleAuthProvider = firebase.GoogleAuthProvider();
      await _auth.signInWithProvider(googleAuthProvider);

      emailController.text = _user?.email ?? '';
      passwordController.text = _user?.photoURL ?? '';
      print(_user?.displayName);
    } catch (err) {
      print(err);
    }
  }
}

 //FIREBASE
