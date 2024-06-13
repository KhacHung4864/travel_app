import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/trips/trip_controller.dart';

class TripBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TripController());
  }
}
