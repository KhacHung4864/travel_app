import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/data/model/places_trip_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';

class CreateTripController extends GetxController {
  CreateTripController();
  final HomeApi _homeApi = HomeApi();
  String tripName = '';

  RxInt person = 1.obs;
  var startDate = 0.obs;
  var returnDate = 0.obs;

  RxList<PlaceTrip> listPlaceTrip = <PlaceTrip>[].obs;

  RxBool isCheck = false.obs;
  List<String> listDate = [];

  Rx<String> selectedDate = ''.obs;

  Rx<int> selectedVehicle = 1.obs;
  Rx<TimeOfDay?> selectedTime = TimeOfDay.now().obs;
  Position? position;

  @override
  void onInit() {
    super.onInit();
  }

  checkDate() {
    if (startDate.value == 0 || returnDate.value == 0) {
      isCheck.value = true;
    }
  }

  // Future<void> get({Map<String, dynamic>? data, int? userId}) async {
  //   try {
  //     final response = await _homeApi.callPlaceTrip();
  //     BaseModel resData = BaseModel.fromJson(response.data);
  //     if (response.statusCode == 200) {
  //       if (resData.code == 0) {
  //       } else {
  //         showError(resData.message);
  //       }
  //     } else {
  //       showError(resData.message);
  //     }
  //   } on DioException catch (e) {
  //     final ApiException apiException = ApiException.fromDioError(e);
  //     throw apiException;
  //   }
  // }

  List<String> generateDateList(int startTimestamp, int endTimestamp) {
    // Chuyển đổi timestamp thành DateTime
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(endTimestamp);

    // Tạo danh sách chứa các ngày
    List<String> dateList = [];
    DateTime currentDate = startDate;
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      dateList.add(dateFormat.format(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return dateList;
  }

  void getCurrentLocation() async {
    position = await checkPermisson();
    print(position?.latitude);
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
}
