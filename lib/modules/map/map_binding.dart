import 'package:get/get.dart';
import 'package:travel_app/modules/map/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapController());
  }
}
