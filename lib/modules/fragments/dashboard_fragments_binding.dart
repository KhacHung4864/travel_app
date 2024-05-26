import 'package:get/get.dart';
import 'package:travel_app/modules/cart/cart_controller.dart';
import 'package:travel_app/modules/fragments/search_place/search_item_controller.dart';
import 'package:travel_app/modules/fragments/trips/trip_controller.dart';

import 'dashboard_fragments_controller.dart';
import 'favorites/favorites_controller.dart';
import 'home/home_controller.dart';
import 'profile/proflile_controller.dart';

class DashboardFragmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardFragmentsController());

    //Home
    Get.put(HomeController());

    //search item
    Get.put(SearchItemController());

    //Oder
    Get.lazyPut<TripController>(() => TripController());

    //Profile
    Get.lazyPut<ProfileController>(() => ProfileController());

    //Favorites
    Get.lazyPut<FavoritesController>(() => FavoritesController());

    //Cart
    Get.lazyPut<CartController>(() => CartController());
    // Get.put(CartController());
  }
}
