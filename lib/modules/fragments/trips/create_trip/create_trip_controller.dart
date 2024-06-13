import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/data/model/base_model.dart';
import 'package:travel_app/data/model/list_trip_model.dart';
import 'package:travel_app/data/model/places/create_trip_model.dart';
import 'package:travel_app/data/model/places/place_trip_model.dart';
import 'package:travel_app/data/network/api/home_api/home_api.dart';
import 'package:travel_app/data/network/service/api_exception.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/modules/fragments/trips/trip_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class CreateTripController extends GetxController {
  CreateTripController();
  final HomeApi _homeApi = HomeApi();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final TripController tripController = Get.find();
  TextEditingController tripName = TextEditingController();

  RxInt person = 1.obs;
  var startDate = 0.obs;
  var returnDate = 0.obs;

  RxList<PlaceTrip> listPlaceTrip = <PlaceTrip>[].obs;
  Map<String, RxList<PlaceTrip>> placeTripsByDate = {};

  RxBool isCheck = false.obs;
  List<String> listDate = [];

  Rx<String> selectedDate = ''.obs;

  Rx<int> selectedVehicle = 1.obs;
  Rx<TimeOfDay?> selectedTime = TimeOfDay.now().obs;

  @override
  void onInit() {
    if (tripController.isEdit == true) {
      final Trips trip = tripController.selectedTrip;
      tripName.text = trip.name ?? '';
      startDate.value = trip.fromDate! * 1000;
      returnDate.value = trip.toDate! * 1000;
      updateDateList();
      person.value = trip.users ?? 1;
      for (int i = 0; i < listDate.length; i++) {
        placeTripsByDate[listDate[i]]?.value = trip.days![i].places!;
      }
    }
    super.onInit();
  }

  Future<void> createTrip() async {
    final dataCreateTrip = CreateTripModel(
            owner: dashboardFragmentsController.currentUser.value?.id,
            name: tripName.text,
            fromDate: startDate.value ~/ 1000,
            toDate: returnDate.value ~/ 1000,
            users: person.value,
            days: listDate
                .map((e) => Days(
                    places: placeTripsByDate[e]
                        ?.map((element) => CrPlaceTrip(
                              id: element.id,
                              note: element.note,
                              visitTime: element.visitTime,
                              startTime: element.startTime,
                              vehicle: element.vehicle,
                            ))
                        .toList()))
                .toList())
        .toJson();
    try {
      final response =
          tripController.isEdit == true ? await _homeApi.callUpdateTrip(data: dataCreateTrip, tripId: tripController.selectedTrip.id) : await _homeApi.callCreateTrip(data: dataCreateTrip);
      BaseModel resData = BaseModel.fromJson(response.data);
      if (response.statusCode == 200) {
        if (resData.code == 0) {
          Fluttertoast.showToast(msg: resData.message ?? '');
        } else {
          showError(resData.message);
        }
      } else {
        showError(resData.message);
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    } finally {}
  }

  void updateDateList() {
    if (startDate.value != 0 && returnDate.value != 0) {
      listDate = generateDateList(startDate.value, returnDate.value);
      // Tạo các danh sách địa điểm trống cho mỗi ngày
      for (var date in listDate) {
        if (!placeTripsByDate.containsKey(date)) {
          placeTripsByDate[date] = <PlaceTrip>[].obs;
        }
      }
    }
  }

  checkDate() {
    if (startDate.value == 0 || returnDate.value == 0) {
      isCheck.value = true;
    }
  }

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
}
