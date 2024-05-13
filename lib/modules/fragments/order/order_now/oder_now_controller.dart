import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/data/model/cart_model.dart';
import 'package:travel_app/data/network/api/cart_api/cart_api.dart';
import 'package:travel_app/modules/cart/cart_controller.dart';

class OrderNowController extends GetxController {
  final CartApi cartApi = CartApi();
  final CartController cartController = Get.find();

  List<String> deliverySystemNamesList = ["FedEx", "DHL", "United Parcel Service"];
  List<String> paymentSystemNamesList = ["Apple Pay", "Wire Transfer", "Google Pay"];
  RxString deliverySystem = "FedEx".obs;
  RxString paymentSystem = "Apple Pay".obs;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController shipmentAddressController = TextEditingController();
  TextEditingController noteToSellerController = TextEditingController();

  RxList<CartData> selectedCartListItemsInfo = <CartData>[].obs;
  Rx<double> totalAmount = 0.0.obs;

  @override
  void onInit() async {
    // await getSelectedCartListItemsInformation();
    super.onInit();
  }

  getSelectedCartListItemsInformation() {
    totalAmount.value = cartController.total.value;
    for (var selectedCartListItem in cartController.cartList) {
      if (cartController.selectedItemList.contains(selectedCartListItem.cartId)) {
        selectedCartListItemsInfo.add(selectedCartListItem);
      }
    }
  }
}
