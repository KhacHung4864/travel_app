import 'package:get/get.dart';
import 'package:travel_app/modules/place_item/place_item_controller.dart';

class PlaceItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlaceItemController());
  }
}
