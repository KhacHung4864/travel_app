import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/comment_models.dart';
import 'package:travel_app/data/model/places/place_detail_model.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class PlaceItemController extends GetxController {
  PlaceItemController();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final HomeApi _homeApi = HomeApi();
  int? placeId = Get.arguments[0];

  Rx<Places> placeItem1 = Places().obs;
  Places get placeItem => placeItem1.value;

  RxBool isLoading = false.obs;

  RxList<Comments> listComments = <Comments>[].obs;

  final TextEditingController commentController = TextEditingController();
  Rx<int> rating = 0.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData({isShowLoading = true}) async {
    isLoading.value = true;
    if (isShowLoading) EasyLoading.show(status: 'Loading...');
    await Future.wait([
      getPlaceComments(placeId: placeId, isShowdLoading: false),
      getPlaceDetail(),
    ]);
    if (isShowLoading) EasyLoading.dismiss();
    isLoading.value = false;
  }

  Future<List<Places>?> getPlaceDetail() async {
    try {
      final response = await _homeApi.callPlaceDetail(placeId: placeId);
      PlaceDetailModel resData = PlaceDetailModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          placeItem1.value = resData.data!.place!;
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
    return null;
  }

  Future getPlaceComments({int? placeId, bool? isShowdLoading}) async {
    try {
      final response = await _homeApi.getPlaceComments(placeId: placeId, isShowdLoading: isShowdLoading);
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listComments.value = [];
          resData.data?.comments?.forEach((record) {
            listComments.add(record);
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
  }

  Future<Places?> createComment({int? rate, String? comment}) async {
    EasyLoading.show(status: 'Loading...');
    try {
      final response = await _homeApi.callCreateComment(data: {
        "user_id": dashboardFragmentsController.currentUser.value?.id,
        "rate": rate,
        "comment": comment,
        "place_id": placeId,
      });
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          await getPlaceComments(placeId: placeId, isShowdLoading: false);
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
      EasyLoading.dismiss();
    }
    return null;
  }

  Future<Places?> updateComment({int? commentId, int? rate, String? comment}) async {
    try {
      EasyLoading.show(status: 'Loading...');
      final response = await _homeApi.callUpdateComment(commentId: commentId, data: {"rate": rate, "comment": comment});
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          await getPlaceComments(placeId: placeId, isShowdLoading: false);
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
      EasyLoading.dismiss();
    }
    return null;
  }

  Future<Places?> deleteComment({Comments? commentItem}) async {
    try {
      final response = await _homeApi.callDeleteComment(commentId: commentItem?.id);
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          listComments.remove(commentItem);
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
    return null;
  }
}
