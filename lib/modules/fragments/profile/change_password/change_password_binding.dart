import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/profile/change_password/change_password_controller.dart';

class ChangePassBindigs extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangePassController());
  }
}
