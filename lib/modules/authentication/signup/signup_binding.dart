import 'package:get/get.dart';
import 'package:travel_app/modules/authentication/signup/signup_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController());
  }
}
