import 'package:get/get.dart';
import 'package:travel_app/data/local/app_storage.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => AppStorage().sharedPreferences());
  }
}
