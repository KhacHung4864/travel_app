import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/add_place/add_place_controller.dart';

class AddPlaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddPlaceController());
  }
}
