// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:travel_app/utils/share_components/dialog/dialog.dart';

class DashboardFragmentsScreen extends GetView<DashboardFragmentsController> {
  const DashboardFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.backButtonPressCount.value == 1) {
          Future.delayed(Duration.zero, () {
            SystemNavigator.pop();
          });
        } else {
          controller.backButtonPressCount.value = 1;
          showError('Press back again to exit');
          Future.delayed(const Duration(seconds: 2), () {
            controller.backButtonPressCount.value = 0;
          });
        }
        return false;
      },
      child: Obx(() {
        return Scaffold(
          // appBar: CommonWidget.appBar(context, controller.tabNames[controller.currentIndexs.value], centerTitle: false),
          body: SafeArea(child: controller.fragmentScreen[controller.currentIndexs.value]),
          backgroundColor: Palette.white,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndexs.value,
            onTap: (value) {
              controller.currentIndexs.value = value;
              controller.tabBottomBar();
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Palette.blueFF0D6EFD,
            unselectedItemColor: Palette.black7C838D,
            items: List.generate(4, (index) {
              var navbtn = controller.navigationButton[index];
              return BottomNavigationBarItem(
                backgroundColor: Palette.white,
                icon: Icon(navbtn['non_active_icon']),
                activeIcon: Icon(navbtn['active_icon']),
                label: navbtn['label'],
              );
            }),
          ),
        );
      }),
    );
  }
}
