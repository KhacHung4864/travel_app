import 'package:get/get.dart';
import 'package:travel_app/modules/cart/cart_controller.dart';
import 'package:travel_app/modules/fragments/order/order_confirmation/order_confirmation_controller.dart';
import 'package:travel_app/modules/fragments/order/order_controller.dart';
import 'package:travel_app/modules/fragments/order/order_detail/order_detail_controller.dart';
import 'package:travel_app/modules/place_item/search_place/search_item_controller.dart';

import 'dashboard_fragments_controller.dart';
import 'favorites/favorites_controller.dart';
import 'home/home_controller.dart';
import 'order/order_now/oder_now_controller.dart';
import 'profile/proflile_controller.dart';

class DashboardFragmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardFragmentsController());

    //Home
    Get.put(HomeController());

    //Oder
    Get.lazyPut<OrderController>(() => OrderController());

    //Profile
    Get.lazyPut<ProfileController>(() => ProfileController());

    //search item
    Get.lazyPut<SearchItemController>(() => SearchItemController());

    //Favorites
    Get.lazyPut<FavoritesController>(() => FavoritesController());

    //Cart
    Get.lazyPut<CartController>(() => CartController());
    // Get.put(CartController());

    Get.lazyPut<OrderConfirmationController>(() => OrderConfirmationController());

    Get.lazyPut<OrderNowController>(() => OrderNowController());

    Get.lazyPut<OrderDetailController>(() => OrderDetailController());
  }
}
