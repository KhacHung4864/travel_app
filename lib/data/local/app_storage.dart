import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage extends GetxService {
  static final AppStorage _appStorage = AppStorage._internal();

  factory AppStorage() {
    return _appStorage;
  }
  AppStorage._internal();

  Future<SharedPreferences> sharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    SharedPreferences pref = Get.find();
    pref.setString(key, value);
  }

  String? getString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getString(key);
  }

  setInt(String key, int value) {
    SharedPreferences pref = Get.find();
    pref.setInt(key, value);
  }

  int? getInt(String key) {
    SharedPreferences pref = Get.find();
    return pref.getInt(key);
  }

  setListString(String key, List<String> value) {
    SharedPreferences pref = Get.find();
    pref.setStringList(key, value);
  }

  List<String>? getListString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getStringList(key);
  }

  Future removeString(String key) async {
    SharedPreferences pref = Get.find();
    pref.remove(key);
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class SKeys {
  static const tokenUser = 'tokenUser';
  static const tokenAdmin = 'tokenAdmin';
  static const currentUser = 'currentUser';
  static const chatGPT = 'chatGPT';
  // static const sessionId = 'sessionId';
  // static const account = 'account';
  // static const countOtp = 'countOtp';
  // static const timeStart = 'time';
  // static const idLibrary = 'idLibrary';
  // static const titleFolder = 'titleFolder';
  // static const userId = 'userId';
  // static const inforResultDisplay = 'inforResultDisplay';
  // static const postId = 'linkUrl';
  // static const email = 'email';
}
