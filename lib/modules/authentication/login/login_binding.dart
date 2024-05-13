import 'package:get/get.dart';
import 'package:travel_app/modules/authentication/login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
