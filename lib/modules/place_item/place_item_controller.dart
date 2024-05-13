import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/places/place_detail_model.dart';
import 'package:travel_app/data/model/places/place_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class PlaceItemController extends GetxController {
  PlaceItemController();
  final HomeApi _homeApi = HomeApi();
  Places? placeItem = Get.arguments[0];

  @override
  void onInit() {
    super.onInit();
  }

  Future<Places?> getPlaceDetail({int? placeId}) async {
    try {
      final response = await _homeApi.callPlaceDetail(placeId: placeId);
      PlaceDetailModel resData = PlaceDetailModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          placeItem = resData.data?.place;
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
