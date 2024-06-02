import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travel_app/configs/app_fonts.dart';
import 'package:travel_app/configs/palette.dart';
import 'package:travel_app/modules/authentication/widget/text_form_field_widget.dart';
import 'package:travel_app/modules/fragments/profile/change_password/change_password_controller.dart';

class ChangePassScreen extends GetView<ChangePassController> {
  ChangePassScreen({super.key});
  final formKey = GlobalKey<FormState>();

  void submit(context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || controller.oldPassController.text.trim().isEmpty) {
      return;
    }
    await controller.changePassword(data: {
      "old_password": controller.oldPassController.text.trim(), // mật khẩu cũ
      "new_password": controller.newPassController.text.trim(), // mật khẩu mới
      "confirm_password": controller.confirmPassController.text.trim(), // xác nhận mật khẩu
    });

    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        centerTitle: true,
      ),
      backgroundColor: Palette.white,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Text('Change password', style: AppFont.t.s(26).w600),

                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Enter Old Password and New Password to make changes',
                      style: AppFont.t.s(16).black7C838D,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),
                  //login screen sign-in form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        //email-pasword-login-btn
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              //email
                              TextFormFieldWidget(
                                title: 'Old Password',
                                isPassword: true,
                                controller: controller.oldPassController,
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid old password.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormFieldWidget(
                                title: 'New Password',
                                isPassword: true,
                                controller: controller.newPassController,
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid new password.';
                                  }
                                  if (controller.newPassController.text != controller.confirmPassController.text) {
                                    return 'The new password is not the same.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              TextFormFieldWidget(
                                title: 'Confirm Password',
                                isPassword: true,
                                controller: controller.confirmPassController,
                                icon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid confirm password.';
                                  }
                                  if (controller.newPassController.text != controller.confirmPassController.text) {
                                    return 'The new password is not the same.';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 40),

                              //button
                              Container(
                                width: Get.width,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.sp),
                                  color: Palette.blueFF0D6EFD,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(16.sp),
                                    onTap: () {
                                      submit(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'Change Password',
                                        style: AppFont.t.s(16).w500.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        //dont have an account btn
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
