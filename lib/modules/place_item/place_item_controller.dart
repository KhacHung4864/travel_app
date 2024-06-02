import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/comment_models.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class PlaceItemController extends GetxController {
  PlaceItemController();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final HomeApi _homeApi = HomeApi();
  Places? placeItem = Get.arguments[0];
  RxList<Comments> listComments = <Comments>[].obs;

  final TextEditingController commentController = TextEditingController();
  Rx<int> rating = 0.obs;

  @override
  void onInit() {
    getPlaceComments(placeId: placeItem?.id);
    super.onInit();
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
        "place_id": placeItem?.id,
      });
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          await getPlaceComments(placeId: placeItem?.id, isShowdLoading: false);
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
    return placeItem;
  }

  Future<Places?> updateComment({int? commentId, int? rate, String? comment}) async {
    try {
      EasyLoading.show(status: 'Loading...');
      final response = await _homeApi.callUpdateComment(commentId: commentId, data: {"rate": rate, "comment": comment});
      CommentModel resData = CommentModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          await getPlaceComments(placeId: placeItem?.id, isShowdLoading: false);
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

    return placeItem;
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
    return placeItem;
  }
}
