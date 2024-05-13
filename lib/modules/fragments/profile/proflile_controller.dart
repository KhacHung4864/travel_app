import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/routes/app_pages.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';
import 'package:travel_app/utils/share_components/dialog/toast.dart';

class ProfileController extends GetxController {
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  void signOutUser() async {
    var resultConfirm = await showDialogConfirm('Logout', 'Are you sure?\nYou want to logout from app?');
    if (resultConfirm == 'loggedOut') {
      await AppStorage().clearAllData();
      Get.offAllNamed(Routes.login);
    }
  }

  void showNotifiCation() async {
    ToastUtil.showText("The feature will be updated in the next version.");
  }
}
