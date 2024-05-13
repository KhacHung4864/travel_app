import 'package:get/get.dart';
import 'package:travel_app/modules/fragments/profile/account/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AccountController());
  }
}
