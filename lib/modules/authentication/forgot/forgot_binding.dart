import 'package:get/get.dart';
import 'package:travel_app/modules/authentication/forgot/forgot_controller.dart';

class ForgotBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotController());
  }
}
