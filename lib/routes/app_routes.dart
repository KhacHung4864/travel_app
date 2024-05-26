import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:travel_app/modules/authentication/forgot/forgot_binding.dart';
import 'package:travel_app/modules/authentication/forgot/forgot_screen.dart';
import 'package:travel_app/modules/authentication/login/login_binding.dart';
import 'package:travel_app/modules/authentication/login/login_screen.dart';
import 'package:travel_app/modules/authentication/signup/signup_binding.dart';
import 'package:travel_app/modules/authentication/signup/signup_screen.dart';
import 'package:travel_app/modules/chatGPT/chatgpt_screen.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_binding.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_screen.dart';
import 'package:travel_app/modules/fragments/profile/account/account_binding.dart';
import 'package:travel_app/modules/fragments/profile/account/account_screen.dart';
import 'package:travel_app/modules/fragments/search_place/search_item_screen.dart';
import 'package:travel_app/modules/fragments/trips/trip_screen.dart';
import 'package:travel_app/modules/map/map_binding.dart';
import 'package:travel_app/modules/map/map_screen.dart';
import 'package:travel_app/modules/place_item/place_item_binding.dart';
import 'package:travel_app/modules/place_item/place_item_screen.dart';
import 'package:travel_app/routes/app_pages.dart';

class AppPages {
  static String initial = Routes.login;

  static final routes = [
    //user
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.forgot,
      page: () => ForgotScreen(),
      binding: ForgotBindings(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.dashBoardFragment,
      page: () => const DashboardFragmentsScreen(),
      binding: DashboardFragmentsBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    //oder
    GetPage(
      name: Routes.order,
      page: () => const TripScreen(),
      binding: DashboardFragmentsBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),

    GetPage(
      name: Routes.searchSreen,
      page: () => const SearchScreen(),
      binding: DashboardFragmentsBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.placeDetail,
      page: () => const PlaceItemPage(),
      binding: PlaceItemBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),

    //New
    GetPage(
      name: Routes.account,
      page: () => const AccountScreen(),
      binding: AccountBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    //chat GPT
    GetPage(
      name: Routes.chatGPT,
      page: () => const ChatGPTScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
    //map
    GetPage(
      name: Routes.map,
      page: () => const MapScreen(),
      binding: MapBinding(),
      transition: Transition.rightToLeft,
      curve: Curves.fastOutSlowIn,
      fullscreenDialog: true,
    ),
  ];
}
