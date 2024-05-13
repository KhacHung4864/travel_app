import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/gen/assets.gen.dart';
import 'package:travel_app/modules/fragments/profile/account/account_controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bio-data",
          style: AppFont.t.w600.s(18).copyWith(color: Colors.black, fontFamily: 'Manrope Bold'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(padding: EdgeInsets.all(32.sp), children: [
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              _userInforAvatar(),
              SizedBox(height: 20.h),
              GetBuilder(
                  init: controller,
                  builder: (context) {
                    return Text(
                      controller.nameController.text,
                      style: AppFont.t.w700.s(16).copyWith(color: Colors.black, fontFamily: 'Manrope Bold'),
                    );
                  }),
              Text(
                controller.email.value ?? '',
                style: AppFont.t.w400.s(13).copyWith(
                      color: const Color(0xFFABABAB),
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        userInforItem(
          title: "Name",
          hintext: "Enter your name",
          controller: controller.nameController,
        ),
        SizedBox(height: 10.h),
        dobItem(context),
        SizedBox(height: 10.h),
        genderItem(),
        SizedBox(height: 10.h),
        userInforItem(title: "Contact", hintext: "Enter your contact", controller: controller.contacController, keyboardType: TextInputType.phone),
        SizedBox(height: 34.h),
        Container(
          width: Get.width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.sp),
            color: Palette.blueFF0600B3,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              borderRadius: BorderRadius.circular(16.sp),
              onTap: controller.submit,
              child: Center(
                child: Text(
                  'Update Profile',
                  style: AppFont.t.s(14).w600.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ]),
    );
  }

  Column genderItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppFont.t.s(12).copyWith(color: Palette.blue),
        ),
        const SizedBox(height: 5),
        Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Palette.blackF6F6F8,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Stack(
              children: [
                DropdownButton<String>(
                  value: controller.gender.value == '' ? null : controller.gender.value,
                  menuMaxHeight: 200,
                  items: controller.listGender
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Builder(
                            builder: (context) {
                              return Text(
                                e,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.gender.value = value;
                  },
                  hint: Text(
                    'Choose gender',
                    style: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  underline: const SizedBox.shrink(),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget dobItem(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date of birth',
            style: AppFont.t.s(12).copyWith(color: Palette.blue),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              var pickDate = await showDatePicker(
                  context: context,
                  initialDate: controller.selectedDate.value != 0 ? DateTime.fromMillisecondsSinceEpoch(controller.selectedDate.value) : DateTime.now(),
                  firstDate: DateTime(1700),
                  lastDate: DateTime.now());
              if (pickDate != null) {
                controller.selectedDate.value = pickDate.millisecondsSinceEpoch;
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: Palette.blackF6F6F8,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (controller.selectedDate.value == 0) ? 'dd/MM/yyyy'.tr : DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(controller.selectedDate.value)),
                    style: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Column userInforItem({String? title, bool isEmail = false, String? hintext, TextEditingController? controller, TextInputType? keyboardType, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: AppFont.t.s(12).copyWith(color: isEmail ? Palette.grey : Palette.blue),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              errorStyle: AppFont.t.red.s(13),
              hintText: hintext,
              hintStyle: AppFont.t.s(13).w700.copyWith(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.sp),
                borderSide: const BorderSide(color: Colors.white60),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 18,
              ),
              fillColor: Palette.blackF6F6F8,
              filled: true),
          validator: validator,
        )
      ],
    );
  }

  Obx _userInforAvatar() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          showDialogBoxForImagePickingAndCapturing();
        },
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: Palette.amber,
            ),
            image: controller.pickedImageXfile.value != null
                ? DecorationImage(
                    image: FileImage(
                      File(controller.pickedImageXfile.value!.path),
                    ),
                    fit: BoxFit.cover)
                : controller.imageLink.value != ''
                    ? DecorationImage(
                        image: NetworkImage(controller.imageLink.value ?? ''),
                        fit: BoxFit.cover,
                      )
                    : null,
          ),
          child: controller.pickedImageXfile.value == null && controller.imageLink.value == ''
              ? Center(
                  child: SizedBox(
                      height: 30,
                      child: SvgPicture.asset(
                        Assets.svg.svgCamera,
                        height: 30.h,
                      )),
                )
              : null,
        ),
      );
    });
  }

  //show box select pick image method
  Future showDialogBoxForImagePickingAndCapturing() {
    return Get.dialog(SimpleDialog(
      backgroundColor: Palette.black,
      title: Text(
        'Pick Avatar',
        style: AppFont.t.bold.deepPurple,
      ),
      children: [
        SimpleDialogOption(
          onPressed: controller.captureImageWithPhoneCamera,
          child: Text(
            'Capture with Phone Camera',
            style: AppFont.t.grey,
          ),
        ),
        SimpleDialogOption(
          onPressed: controller.pickImageFromPhoneGallery,
          child: Text(
            'Pick Image From Phone Gallery',
            style: AppFont.t.grey,
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: AppFont.t.red,
          ),
        )
      ],
    ));
  }
}
