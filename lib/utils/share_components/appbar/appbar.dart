import 'package:flutter/material.dart';
import 'package:travel_app/configs/app_fonts.dart';

class CommonWidget {
  static AppBar appBar(
    BuildContext context,
    String title, {
    Widget? titleWidget,
    IconButton? leading,
    List<Widget>? actions,
    bool isShowSearch = false,
    Widget? searchField,
    bool centerTitle = true,
    Function()? onBack,
  }) {
    return AppBar(
      // leading: leading ??
      //     IconButton(
      //       icon: const Icon(Icons.arrow_back, color: Colors.black),
      //       onPressed: onBack ??
      //           () {
      //             Get.back();
      //           },
      //     ),
      centerTitle: centerTitle ? true : false,
      title: titleWidget ??
          (isShowSearch
              ? searchField
              : Text(
                  title,
                  style: AppFont.t.w600.s(18).copyWith(color: Colors.black, fontFamily: 'Manrope Bold'),
                )),
      actions: isShowSearch ? null : actions,
      backgroundColor: Colors.transparent,
      titleSpacing: 0,
      scrolledUnderElevation: 0,
    );
  }
}
