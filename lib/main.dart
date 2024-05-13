import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/data/local/app_storage.dart';
import 'package:travel_app/data/local/di.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/modules/authentication/login/login_screen.dart';
import 'package:travel_app/routes/app_pages.dart';
import 'package:travel_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Đảm bảo rằng Flutter đã được khởi tạo và đã sẵn sàng để chạy ứng dụng.

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configLoading();
  //Kiểm tra xem người dùng đăng nhập lần đầu hay chưa
  await DependencyInjection.init();
  String? tokenUser = AppStorage().getString(SKeys.tokenUser);
  if (tokenUser != null && tokenUser.isNotEmpty) {
    AppPages.initial = Routes.dashBoardFragment;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData().copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: Palette.white, fontSize: 24),
                iconTheme: IconThemeData(color: Palette.white),
              ),
            ),
            initialRoute: AppPages.initial,
            getPages: AppPages.routes,
            home: LoginScreen(),
            builder: EasyLoading.init(
              builder: ((context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: GestureDetector(
                    onTap: () => FocusScope.of(Get.context!).requestFocus(FocusNode()),
                    behavior: HitTestBehavior.translucent,
                    child: widget!,
                  ),
                );
              }),
            )));
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false;
}
