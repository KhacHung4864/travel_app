import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/trips/create_trip/create_trip_controller.dart';

class CreateTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateTripController());
  }
}
