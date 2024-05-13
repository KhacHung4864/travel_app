import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:travel_app/modules/authentication/login/login_binding.dart';
import 'package:travel_app/modules/authentication/login/login_screen.dart';
import 'package:travel_app/modules/authentication/signup/signup_binding.dart';
import 'package:travel_app/modules/authentication/signup/signup_screen.dart';
import 'package:travel_app/modules/chatGPT/chatgpt_screen.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_binding.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_screen.dart';
import 'package:travel_app/modules/fragments/order/order_confirmation/order_confirmation_screen.dart';
import 'package:travel_app/modules/fragments/order/order_detail/order_detail_screen.dart';
import 'package:travel_app/modules/fragments/order/order_history/order_history_screen.dart';
import 'package:travel_app/modules/fragments/order/order_now/order_now_screen.dart';
import 'package:travel_app/modules/fragments/order/order_screen.dart';
import 'package:travel_app/modules/fragments/profile/account/account_binding.dart';
import 'package:travel_app/modules/fragments/profile/account/account_screen.dart';
import 'package:travel_app/modules/map/map_binding.dart';
import 'package:travel_app/modules/map/map_screen.dart';
import 'package:travel_app/modules/place_item/place_item_binding.dart';
import 'package:travel_app/modules/place_item/place_item_screen.dart';
import 'package:travel_app/modules/place_item/search_place/search_item_screen.dart';
import 'package:travel_app/routes/app_pages.dart';

class AppPages {
  static String initial = Routes.login;

  static final routes = [
    //user
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: Routes.dashBoardFragment,
      page: () => const DashboardFragmentsScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    //oder
    GetPage(
      name: Routes.order,
      page: () => const OrderScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderNow,
      page: () => const OrderNowScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderConfirmation,
      page: () => const OrderConfirmationScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderDetail,
      page: () => const OrderDetailScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderHistory,
      page: () => const OrderHistoryScreen(),
      binding: DashboardFragmentsBinding(),
    ),

    GetPage(
      name: Routes.searchSreen,
      page: () => const SearchScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.placeDetail,
      page: () => const PlaceItemPage(),
      binding: PlaceItemBinding(),
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
    ),
    //map
    GetPage(
      name: Routes.map,
      page: () => const MapScreen(),
      binding: MapBinding(),
    ),
  ];
}
