import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/data/model/base_model.dart';
import 'package:travel_app/data/network/api/user_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';
import 'package:travel_app/utils/share_components/dialog/toast.dart';

import '../../dashboard_fragments_controller.dart';

class AccountController extends GetxController {
  final UserApi _userApi = UserApi();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  final ImagePicker picker = ImagePicker();
  Rx<XFile?> pickedImageXfile = Rx<XFile?>(null);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contacController = TextEditingController();
  var selectedDate = 0.obs;
  Rx<String?> gender = ''.obs;
  Rx<String?> email = ''.obs;
  final List<String> listGender = ['Male', 'Female'];
  Rx<String?> imageLink = ''.obs;

  String fileImage = '';

  @override
  void onInit() {
    imageLink.value = dashboardFragmentsController.currentUser.value?.avatar ?? '';
    email.value = dashboardFragmentsController.currentUser.value?.email;
    nameController.text = dashboardFragmentsController.currentUser.value?.username ?? '';
    gender.value = dashboardFragmentsController.currentUser.value?.gender == 1 ? 'Male' : (dashboardFragmentsController.currentUser.value?.gender == 2 ? 'Female' : '');
    selectedDate.value = (dashboardFragmentsController.currentUser.value?.birthDay ?? 0) * 1000;
    contacController.text = dashboardFragmentsController.currentUser.value?.contact ?? '';
    super.onInit();
  }

  void submit() async {
    if (nameController.text.trim().isEmpty) {
      ToastUtil.showText("Please enter a valid name.");
      return;
    }
    if (pickedImageXfile.value != null) {
      await uploadImage();
    }
    await uploadUserInfor(
      data: {
        "username": nameController.text.trim(),
        "birth_day": selectedDate.value ~/ 1000, // unix timestamp
        "gender": gender.value == 'Male' ? 1 : (gender.value == 'Female' ? 2 : 0), // 1 nam, 2 nữ
        "avatar": fileImage,
        "contact": contacController.text.trim()
      },
      userId: dashboardFragmentsController.currentUser.value?.id,
    );
    update();
  }

  Future<void> uploadImage() async {
    try {
      final response = await _userApi.callUpLoadItemImage(pickedImageXfile.value!.path);
      BaseModel resData = BaseModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          fileImage = resData.data?.file ?? '';
        } else {
          showError(resData.message);
        }
      } else {
        showError('Error when uploading photos. Error code:  ${response.statusCode}');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }

  Future<void> uploadUserInfor({Map<String, dynamic>? data, int? userId}) async {
    try {
      final response = await _userApi.callUpdateProfile(data: data, userId: userId);
      BaseModel resData = BaseModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          dashboardFragmentsController.getUserData();
          Get.back();
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

  captureImageWithPhoneCamera() async {
    pickedImageXfile.value = await picker.pickImage(source: ImageSource.camera);
    Get.back();
  }

  pickImageFromPhoneGallery() async {
    pickedImageXfile.value = await picker.pickImage(source: ImageSource.gallery);
    Get.back();
  }

  void clearData() {
    pickedImageXfile.value = null;
    nameController.clear();
    contacController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    contacController.dispose();
    super.onClose();
  }
}
